-- DropForeignKey
ALTER TABLE "rating_attachments" DROP CONSTRAINT "rating_attachments_rating_id_fkey";

-- AddForeignKey
ALTER TABLE "rating_attachments" ADD CONSTRAINT "rating_attachments_rating_id_fkey" FOREIGN KEY ("rating_id") REFERENCES "product_ratings"("id") ON DELETE CASCADE ON UPDATE CASCADE;
