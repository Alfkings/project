/*
  Warnings:

  - You are about to drop the column `company_id` on the `employee` table. All the data in the column will be lost.
  - You are about to drop the column `company_id` on the `project` table. All the data in the column will be lost.
  - You are about to drop the column `employeesId` on the `project` table. All the data in the column will be lost.
  - You are about to drop the `Profile` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `companyId` to the `employee` table without a default value. This is not possible if the table is not empty.
  - Added the required column `companyId` to the `project` table without a default value. This is not possible if the table is not empty.
  - Added the required column `employeeId` to the `project` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Profile" DROP CONSTRAINT "Profile_employeesId_fkey";

-- DropForeignKey
ALTER TABLE "employee" DROP CONSTRAINT "employee_company_id_fkey";

-- DropForeignKey
ALTER TABLE "project" DROP CONSTRAINT "project_company_id_fkey";

-- DropForeignKey
ALTER TABLE "project" DROP CONSTRAINT "project_employeesId_fkey";

-- AlterTable
ALTER TABLE "employee" DROP COLUMN "company_id",
ADD COLUMN     "companyId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "project" DROP COLUMN "company_id",
DROP COLUMN "employeesId",
ADD COLUMN     "companyId" INTEGER NOT NULL,
ADD COLUMN     "employeeId" INTEGER NOT NULL;

-- DropTable
DROP TABLE "Profile";

-- CreateTable
CREATE TABLE "profile" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "bloodGroup" TEXT NOT NULL,
    "dateOfBirth" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "employeeId" INTEGER NOT NULL,

    CONSTRAINT "profile_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "employee_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project" ADD CONSTRAINT "project_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES "company"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project" ADD CONSTRAINT "project_employeeId_fkey" FOREIGN KEY ("employeeId") REFERENCES "employee"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "profile" ADD CONSTRAINT "profile_employeeId_fkey" FOREIGN KEY ("employeeId") REFERENCES "employee"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
