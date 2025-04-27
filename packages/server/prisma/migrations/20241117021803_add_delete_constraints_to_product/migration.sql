-- DropForeignKey
ALTER TABLE "product_attachments" DROP CONSTRAINT "product_attachments_product_id_fkey";

-- DropForeignKey
ALTER TABLE "product_questions" DROP CONSTRAINT "product_questions_product_id_fkey";

-- DropForeignKey
ALTER TABLE "product_tags" DROP CONSTRAINT "product_tags_product_id_fkey";

-- AddForeignKey
ALTER TABLE "product_questions" ADD CONSTRAINT "product_questions_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_tags" ADD CONSTRAINT "product_tags_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_attachments" ADD CONSTRAINT "product_attachments_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "products"("id") ON DELETE CASCADE ON UPDATE CASCADE;
