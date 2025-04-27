/*
  Warnings:

  - You are about to drop the column `addedAt` on the `wishlist_items` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "chat_participants" DROP CONSTRAINT "chat_participants_client_id_fkey";

-- DropForeignKey
ALTER TABLE "client_notifications" DROP CONSTRAINT "client_notifications_client_id_fkey";

-- DropForeignKey
ALTER TABLE "messages" DROP CONSTRAINT "messages_profile_id_fkey";

-- DropForeignKey
ALTER TABLE "orders" DROP CONSTRAINT "orders_client_id_fkey";

-- DropForeignKey
ALTER TABLE "product_questions" DROP CONSTRAINT "product_questions_client_id_fkey";

-- DropForeignKey
ALTER TABLE "product_ratings" DROP CONSTRAINT "product_ratings_client_id_fkey";

-- DropForeignKey
ALTER TABLE "shopping_carts" DROP CONSTRAINT "shopping_carts_client_id_fkey";

-- DropForeignKey
ALTER TABLE "wishlists" DROP CONSTRAINT "wishlists_client_id_fkey";

-- AlterTable
ALTER TABLE "messages" ALTER COLUMN "profile_id" DROP NOT NULL;

-- AlterTable
ALTER TABLE "orders" ALTER COLUMN "client_id" DROP NOT NULL;

-- AlterTable
ALTER TABLE "product_questions" ALTER COLUMN "client_id" DROP NOT NULL;

-- AlterTable
ALTER TABLE "product_ratings" ALTER COLUMN "client_id" DROP NOT NULL;

-- AlterTable
ALTER TABLE "wishlist_items" DROP COLUMN "addedAt",
ADD COLUMN     "added_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- AddForeignKey
ALTER TABLE "shopping_carts" ADD CONSTRAINT "shopping_carts_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "clients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wishlists" ADD CONSTRAINT "wishlists_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "clients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "clients"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "messages" ADD CONSTRAINT "messages_profile_id_fkey" FOREIGN KEY ("profile_id") REFERENCES "profiles"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client_notifications" ADD CONSTRAINT "client_notifications_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "clients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "chat_participants" ADD CONSTRAINT "chat_participants_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "clients"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_questions" ADD CONSTRAINT "product_questions_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "clients"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_ratings" ADD CONSTRAINT "product_ratings_client_id_fkey" FOREIGN KEY ("client_id") REFERENCES "clients"("id") ON DELETE SET NULL ON UPDATE CASCADE;
