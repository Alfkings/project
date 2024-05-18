-- DropIndex
DROP INDEX "project_projectManagerId_projectAccountControllerId_idx";

-- CreateIndex
CREATE INDEX "project_projectManagerId_idx" ON "project"("projectManagerId");

-- CreateIndex
CREATE INDEX "project_projectAccountControllerId_idx" ON "project"("projectAccountControllerId");
