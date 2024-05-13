/*
  Warnings:

  - You are about to drop the column `employeeId` on the `project` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "project" DROP CONSTRAINT "project_employeeId_fkey";

-- AlterTable
ALTER TABLE "project" DROP COLUMN "employeeId";

-- CreateTable
CREATE TABLE "_EmployeeToproject" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_EmployeeToproject_AB_unique" ON "_EmployeeToproject"("A", "B");

-- CreateIndex
CREATE INDEX "_EmployeeToproject_B_index" ON "_EmployeeToproject"("B");

-- AddForeignKey
ALTER TABLE "_EmployeeToproject" ADD CONSTRAINT "_EmployeeToproject_A_fkey" FOREIGN KEY ("A") REFERENCES "employee"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_EmployeeToproject" ADD CONSTRAINT "_EmployeeToproject_B_fkey" FOREIGN KEY ("B") REFERENCES "project"("id") ON DELETE CASCADE ON UPDATE CASCADE;
