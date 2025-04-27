-- DropForeignKey
ALTER TABLE "brand_sellers" DROP CONSTRAINT "brand_sellers_country_id_fkey";

-- AlterTable
ALTER TABLE "brand_sellers" ALTER COLUMN "country_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "brand_sellers" ADD CONSTRAINT "brand_sellers_country_id_fkey" FOREIGN KEY ("country_id") REFERENCES "countries"("id") ON DELETE SET NULL ON UPDATE CASCADE;
