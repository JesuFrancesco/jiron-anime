-- DropForeignKey
ALTER TABLE "clients" DROP CONSTRAINT "clients_profile_id_fkey";

-- AddForeignKey
ALTER TABLE "clients" ADD CONSTRAINT "clients_profile_id_fkey" FOREIGN KEY ("profile_id") REFERENCES "profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;
