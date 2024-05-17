/*
  Warnings:

  - A unique constraint covering the columns `[employeeId]` on the table `profile` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "profile_employeeId_key" ON "profile"("employeeId");
