/*
  Warnings:

  - Changed the type of `estematedAmount` on the `project` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- AlterTable
ALTER TABLE "project" DROP COLUMN "estematedAmount",
ADD COLUMN     "estematedAmount" INTEGER NOT NULL;
