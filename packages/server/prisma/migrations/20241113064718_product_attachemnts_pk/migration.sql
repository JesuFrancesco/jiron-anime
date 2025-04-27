/*
  Warnings:

  - The primary key for the `product_attachments` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `brand_seller` on the `products` table. All the data in the column will be lost.
  - The primary key for the `rating_attachments` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `blobUrl` on the `rating_attachments` table. All the data in the column will be lost.
  - Added the required column `has_seen` to the `client_notifications` table without a default value. This is not possible if the table is not empty.
  - Added the required column `blob_url` to the `rating_attachments` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "products" DROP CONSTRAINT "products_brand_seller_fkey";

-- AlterTable
ALTER TABLE "client_notifications" ADD COLUMN     "has_seen" BOOLEAN NOT NULL;

-- AlterTable
ALTER TABLE "clients" ADD COLUMN     "country_id" INTEGER,
ADD COLUMN     "last_name" TEXT,
ADD COLUMN     "name" TEXT,
ADD COLUMN     "pfp_image_url" TEXT;

-- AlterTable
ALTER TABLE "markets" ADD COLUMN     "logo_url" TEXT;

-- AlterTable
ALTER TABLE "product_attachments" DROP CONSTRAINT "product_attachments_pkey",
ADD CONSTRAINT "product_attachments_pkey" PRIMARY KEY ("product_id", "image_url");

-- AlterTable
ALTER TABLE "products" DROP COLUMN "brand_seller",
ADD COLUMN     "brandseller_id" INTEGER;

-- AlterTable
ALTER TABLE "question_replies" ADD COLUMN     "asunto" TEXT;

-- AlterTable
ALTER TABLE "rating_attachments" DROP CONSTRAINT "rating_attachments_pkey",
DROP COLUMN "blobUrl",
ADD COLUMN     "blob_url" TEXT NOT NULL,
ADD CONSTRAINT "rating_attachments_pkey" PRIMARY KEY ("rating_id", "blob_url");

-- AddForeignKey
ALTER TABLE "clients" ADD CONSTRAINT "clients_country_id_fkey" FOREIGN KEY ("country_id") REFERENCES "countries"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_brandseller_id_fkey" FOREIGN KEY ("brandseller_id") REFERENCES "brand_sellers"("id") ON DELETE SET NULL ON UPDATE CASCADE;
