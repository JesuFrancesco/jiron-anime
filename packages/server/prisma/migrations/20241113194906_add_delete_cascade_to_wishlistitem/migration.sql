-- DropForeignKey
ALTER TABLE "wishlist_items" DROP CONSTRAINT "wishlist_items_wishlist_id_fkey";

-- AddForeignKey
ALTER TABLE "wishlist_items" ADD CONSTRAINT "wishlist_items_wishlist_id_fkey" FOREIGN KEY ("wishlist_id") REFERENCES "wishlists"("id") ON DELETE CASCADE ON UPDATE CASCADE;
