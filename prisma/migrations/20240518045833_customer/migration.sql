/*
  Warnings:

  - The primary key for the `project` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `estematedAmount` on the `project` table. All the data in the column will be lost.
  - You are about to drop the column `id` on the `project` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `project` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `project` table. All the data in the column will be lost.
  - Added the required column `DueDate` to the `project` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ProjectOwner` to the `project` table without a default value. This is not possible if the table is not empty.
  - Added the required column `StartDate` to the `project` table without a default value. This is not possible if the table is not empty.
  - Added the required column `customerId` to the `project` table without a default value. This is not possible if the table is not empty.
  - Added the required column `projectGroup` to the `project` table without a default value. This is not possible if the table is not empty.
  - Added the required column `projectName` to the `project` table without a default value. This is not possible if the table is not empty.
  - Added the required column `projectType` to the `project` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "projectType" AS ENUM ('fixed', 'timeAndMaterial', 'progressive');

-- DropForeignKey
ALTER TABLE "employee" DROP CONSTRAINT "employee_projectId_fkey";

-- AlterTable
ALTER TABLE "project" DROP CONSTRAINT "project_pkey",
DROP COLUMN "estematedAmount",
DROP COLUMN "id",
DROP COLUMN "name",
DROP COLUMN "type",
ADD COLUMN     "DueDate" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "ProjectId" SERIAL NOT NULL,
ADD COLUMN     "ProjectOwner" TEXT NOT NULL,
ADD COLUMN     "StartDate" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "customerId" INTEGER NOT NULL,
ADD COLUMN     "projectAccountControllerId" INTEGER,
ADD COLUMN     "projectGroup" TEXT NOT NULL,
ADD COLUMN     "projectManagerId" INTEGER,
ADD COLUMN     "projectName" TEXT NOT NULL,
ADD COLUMN     "projectType" "projectType" NOT NULL,
ADD CONSTRAINT "project_pkey" PRIMARY KEY ("ProjectId");

-- CreateTable
CREATE TABLE "customer" (
    "id" SERIAL NOT NULL,
    "CustomerName" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "customer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customer_profile" (
    "id" SERIAL NOT NULL,
    "companyName" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "pincode" TEXT NOT NULL,
    "fax" TEXT,
    "website" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "customerId" INTEGER,

    CONSTRAINT "customer_profile_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "employee_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "project"("ProjectId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project" ADD CONSTRAINT "project_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "customer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project" ADD CONSTRAINT "project_projectManagerId_fkey" FOREIGN KEY ("projectManagerId") REFERENCES "employee"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project" ADD CONSTRAINT "project_projectAccountControllerId_fkey" FOREIGN KEY ("projectAccountControllerId") REFERENCES "employee"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "customer_profile" ADD CONSTRAINT "customer_profile_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "customer"("id") ON DELETE SET NULL ON UPDATE CASCADE;
