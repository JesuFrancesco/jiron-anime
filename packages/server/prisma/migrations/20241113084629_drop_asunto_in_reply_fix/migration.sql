/*
  Warnings:

  - You are about to drop the column `messageId` on the `message_attachments` table. All the data in the column will be lost.
  - You are about to drop the column `asunto` on the `question_replies` table. All the data in the column will be lost.
  - Added the required column `message_id` to the `message_attachments` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "message_attachments" DROP CONSTRAINT "message_attachments_messageId_fkey";

-- AlterTable
ALTER TABLE "message_attachments" DROP COLUMN "messageId",
ADD COLUMN     "message_id" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "product_questions" ADD COLUMN     "subject" TEXT NOT NULL DEFAULT 'Consulta';

-- AlterTable
ALTER TABLE "question_replies" DROP COLUMN "asunto";

-- AddForeignKey
ALTER TABLE "message_attachments" ADD CONSTRAINT "message_attachments_message_id_fkey" FOREIGN KEY ("message_id") REFERENCES "messages"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
