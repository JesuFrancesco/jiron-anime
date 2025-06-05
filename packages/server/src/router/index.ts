/**
 * disclaimer !!!!!!!!!
 * La presente configuración es bastante insegura de por sí.
 * Su implementación responde únicamente al propósito de tener un CRUD de manera rápida.
 * Una implementación más segura requiere un mejor uso del middleware de Supabase para evitar peticiones que NO deberían ser usados por usuarios externos
 */
import {
  NextFunction,
  Request,
  RequestHandler,
  Response,
  Router,
} from "express";
import { PrismaClient } from "@prisma/client";
import { authHandler } from "../middleware/authorization.handler";
import { commonRouterConfig } from "./const";

// manualmente
import storageRouter from "./storage.router";
import orderRouter from "./order.router";

// prisma generated
import { ProfileRouter } from "../generated/express/Profile";
import { ClientRouter } from "../generated/express/Client";
import { MarketRouter } from "../generated/express/Market";
import { ProductRouter } from "../generated/express/Product";
import { NotificationRouter } from "../generated/express/Notification";
import { ProductRatingRouter } from "../generated/express/ProductRating";
import { ProductQuestionRouter } from "../generated/express/ProductQuestion";
import { ShoppingCartRouter } from "../generated/express/ShoppingCart";
import { CartItemRouter } from "../generated/express/CartItem";
import { WishlistRouter } from "../generated/express/Wishlist";
import { WishlistItemRouter } from "../generated/express/WishlistItem";
import { TagRouter } from "../generated/express/Tag";
import { ProductTagRouter } from "../generated/express/ProductTag";

const API_ROUTER = Router();

// prisma init
const prisma = new PrismaClient();

// custom express + prisma middleware
const addPrisma: RequestHandler = (
  req: Request & { prisma: PrismaClient },
  res: Response,
  next: NextFunction
) => {
  req.prisma = prisma;
  next();
};

API_ROUTER.use(addPrisma);

// == routers habilitados
// protected routes
const profileRouter = ProfileRouter({
  ...commonRouterConfig,
});
API_ROUTER.use(profileRouter);

const clientRouter = ClientRouter({
  ...commonRouterConfig,
});
API_ROUTER.use(clientRouter);

const wishlistRouter = WishlistRouter({
  ...commonRouterConfig,
});
API_ROUTER.use(wishlistRouter);

const wishlistItemRouter = WishlistItemRouter({
  ...commonRouterConfig,
});
API_ROUTER.use(wishlistItemRouter);

const shoppingCartRouter = ShoppingCartRouter({
  ...commonRouterConfig,
});
API_ROUTER.use(shoppingCartRouter);

const cartItemRouter = CartItemRouter({
  ...commonRouterConfig,
});
API_ROUTER.use(cartItemRouter);

API_ROUTER.use(orderRouter);

// public router
API_ROUTER.use(
  ProductRouter(commonRouterConfig),
  MarketRouter(commonRouterConfig),
  ProductRatingRouter(commonRouterConfig),
  ProductQuestionRouter(commonRouterConfig),
  TagRouter(commonRouterConfig),
  ProductTagRouter(commonRouterConfig),
  NotificationRouter(commonRouterConfig)
);

API_ROUTER.use("/storage", storageRouter);

function getPathFromRegexp(regexp: RegExp): string {
  const str = regexp
    .toString()
    .replace(/^\/\^/, "")
    .replace(/\?\(\?=\\\/\|\$\)\/i$/, "")
    .replace(/\\\//g, "/")
    .replace(/\\\./g, ".")
    .replace(/\$$/, "");
  return str.startsWith("/") ? str : `/${str}`;
}

export function listAllRoutesFlat(): string[] {
  const queue: { base: string; stack: any[] }[] = [
    { base: "/api/v1", stack: API_ROUTER.stack },
  ];
  const routes: string[] = [];

  while (queue.length > 0) {
    const { base, stack } = queue.shift()!;

    for (const layer of stack) {
      if (layer.route?.path) {
        const methods = Object.keys(layer.route.methods)
          .filter((m) => layer.route.methods[m])
          .map((m) => m.toUpperCase())
          .join(", ");
        routes.push(`${methods} ${base}${layer.route.path}`);
      } else if (layer.name === "router" && layer.handle?.stack) {
        const path = getPathFromRegexp(layer.regexp);
        queue.push({ base: base + path, stack: layer.handle.stack });
      }
    }
  }

  return routes;
}

export { API_ROUTER };
