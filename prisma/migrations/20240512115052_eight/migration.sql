/*
  Warnings:

  - You are about to drop the `_EmployeeToproject` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `projectId` to the `employee` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "_EmployeeToproject" DROP CONSTRAINT "_EmployeeToproject_A_fkey";

-- DropForeignKey
ALTER TABLE "_EmployeeToproject" DROP CONSTRAINT "_EmployeeToproject_B_fkey";

-- AlterTable
ALTER TABLE "employee" ADD COLUMN     "projectId" INTEGER NOT NULL;

-- DropTable
DROP TABLE "_EmployeeToproject";

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "employee_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
