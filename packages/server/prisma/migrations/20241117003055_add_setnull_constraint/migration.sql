-- DropForeignKey
ALTER TABLE "products" DROP CONSTRAINT "products_market_id_fkey";

-- AlterTable
ALTER TABLE "products" ALTER COLUMN "market_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_market_id_fkey" FOREIGN KEY ("market_id") REFERENCES "markets"("id") ON DELETE SET NULL ON UPDATE CASCADE;
