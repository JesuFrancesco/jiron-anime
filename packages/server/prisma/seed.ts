import "dotenv/config";
import { Client, DatabaseError } from "pg";
import fs from "fs";
import * as log4js from "log4js";

const sql = new Client({
  connectionString: process.env.DIRECT_URL,
});

log4js.configure({
  appenders: {
    consola: { type: "console" },
    detailed: { type: "file", filename: "errors.log", level: "error" },
  },
  categories: {
    default: { appenders: ["consola"], level: "info" },
    error: { appenders: ["detailed"], level: "error" },
  },
});

async function main() {
  const log = log4js.getLogger();
  const errorLog = log4js.getLogger("error");

  await sql.connect();
  log.info("Proceso iniciado");

  // == supabase auth setup
  // ON AUTH.USERS USER CREATED
  await sql.query(`
    CREATE OR REPLACE FUNCTION public.handle_new_user()
    returns trigger as $$
    DECLARE
        clientId INT;
        cartId INT;
        wishlistId INT;

    BEGIN
        INSERT INTO public.profiles (id, image_url, provider, email)
        VALUES (
          new.id, 
          new.raw_app_meta_data->>'avatar_url',
          new.raw_app_meta_data->>'provider',
          new.email
        );

        INSERT INTO public.clients (username, profile_id)
        VALUES (
          new.raw_user_meta_data->>'full_name',  
          new.id
        )
        RETURNING id INTO clientId;

        INSERT INTO public.shopping_carts (client_id)
        VALUES (clientId)
        RETURNING id INTO cartId;

        INSERT INTO public.wishlists (client_id)
        VALUES (clientId)
        RETURNING id INTO wishlistId;

        UPDATE auth.users
        SET
            raw_user_meta_data = jsonb_set(
                jsonb_set(
                    jsonb_set(
                        raw_user_meta_data,
                        '{client_id}', to_jsonb(clientId::integer)
                    ),
                    '{cart_id}', to_jsonb(cartId::integer)
                ),
                '{wishlist_id}', to_jsonb(wishlistId::integer)
            )
        WHERE id = new.id;

        RETURN new;
    END; 
    $$ LANGUAGE PLPGSQL SECURITY DEFINER;
  `);

  await sql.query(`
     CREATE OR REPLACE TRIGGER on_auth_user_created
         AFTER INSERT ON auth.users
         FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();
   `);

  // ON PUBLIC.PROILE USER DELETED
  await sql.query(`
     CREATE OR REPLACE FUNCTION public.handle_user_delete()
     RETURNS TRIGGER AS $$
     BEGIN
       DELETE FROM auth.users WHERE id = old.id;
       return old;
     END;
     $$ LANGUAGE PLPGSQL SECURITY DEFINER;
   `);

  await sql.query(`
    CREATE OR REPLACE TRIGGER on_profile_user_deleted
    AFTER DELETE ON public.profiles
    FOR EACH ROW EXECUTE PROCEDURE public.handle_user_delete()
    `);

  // ON AUTH.USERS USER DELETED
  await sql.query(`
     CREATE OR REPLACE FUNCTION public.handle_sb_user_delete()
     RETURNS TRIGGER AS $$
     BEGIN
       DELETE FROM public.profiles WHERE id = old.id;
       return old;
     END;
     $$ LANGUAGE PLPGSQL SECURITY DEFINER;
   `);

  await sql.query(`
    CREATE OR REPLACE TRIGGER on_profile_user_deleted
    AFTER DELETE ON auth.users
    FOR EACH ROW EXECUTE PROCEDURE public.handle_sb_user_delete()
    `);

  await sql.query(`
    CREATE OR REPLACE FUNCTION update_products_on_market_delete()
    RETURNS TRIGGER AS $$
    BEGIN
        UPDATE products
        SET status = 0
        WHERE market_id = OLD.id;
        RETURN OLD;
    END;
    $$ LANGUAGE PLPGSQL SECURITY DEFINER;
    `);

  await sql.query(`
    CREATE OR REPLACE TRIGGER after_market_delete
    AFTER DELETE ON markets
    FOR EACH ROW EXECUTE PROCEDURE public.update_products_on_market_delete();
    `);

  log.info(
    "Se han agregado los triggers y funciones que se vinculan con supabase."
  );

  // static
  const seedFromSQL = async (filePath: string) => {
    try {
      log.info(`${filePath} | Inicio de seeding de datos estáticos`);
      const data = fs.readFileSync(filePath, "utf-8");
      await sql.query(data);
      log.info(`${filePath} | migrado exitosamente`);
    } catch (error: unknown) {
      if (error instanceof DatabaseError) {
        if (error.code === "23505") {
          log.info(`${filePath} | Ignorando pkey ya establecida...`);
        } else {
          log.warn(
            `${filePath} | Algo salio mal en DB. Más detalle en errors.log`
          );
        }
        errorLog.error(error);
      } else {
        errorLog.error(error);
        log.error(`${filePath} | Algo salio mal.`);
        console.error(error);
      }
    }
  };

  // static
  await seedFromSQL("prisma/seeders/paises.sql");
  await seedFromSQL("prisma/seeders/ubigeos.sql");

  // mock
  await seedFromSQL("prisma/seeders/mock/cuentas.sql"); // working
  await seedFromSQL("prisma/seeders/mock/tags.sql"); // working
  await seedFromSQL("prisma/seeders/mock/notificaciones.sql"); // working
  await seedFromSQL("prisma/seeders/mock/brand_sellers.sql");
  await seedFromSQL("prisma/seeders/mock/products.sql");
  await seedFromSQL("prisma/seeders/mock/product_tags.sql");
  await seedFromSQL("prisma/seeders/mock/product_attachments.sql");

  log.info("Proceso de seeding terminado");

  process.exit();
}

main();
