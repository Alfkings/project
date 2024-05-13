/*
  Warnings:

  - You are about to drop the `employees` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Profile" DROP CONSTRAINT "Profile_employeesId_fkey";

-- DropForeignKey
ALTER TABLE "employees" DROP CONSTRAINT "employees_company_id_fkey";

-- DropForeignKey
ALTER TABLE "project" DROP CONSTRAINT "project_employeesId_fkey";

-- DropTable
DROP TABLE "employees";

-- CreateTable
CREATE TABLE "employee" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "phone" INTEGER NOT NULL,
    "salary" INTEGER NOT NULL,
    "company_id" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "employee_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "employee_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "company"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "project" ADD CONSTRAINT "project_employeesId_fkey" FOREIGN KEY ("employeesId") REFERENCES "employee"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Profile" ADD CONSTRAINT "Profile_employeesId_fkey" FOREIGN KEY ("employeesId") REFERENCES "employee"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
