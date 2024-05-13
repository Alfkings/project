-- DropForeignKey
ALTER TABLE "employee" DROP CONSTRAINT "employee_projectId_fkey";

-- AlterTable
ALTER TABLE "employee" ALTER COLUMN "projectId" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "employee_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "project"("id") ON DELETE SET NULL ON UPDATE CASCADE;
