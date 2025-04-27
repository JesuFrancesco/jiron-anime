/*
  Warnings:

  - You are about to drop the column `filename` on the `rating_attachments` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `rating_attachments` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "rating_attachments" DROP COLUMN "filename",
DROP COLUMN "type";
