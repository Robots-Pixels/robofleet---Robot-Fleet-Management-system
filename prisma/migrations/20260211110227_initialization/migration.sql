-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'OPERATOR');

-- CreateEnum
CREATE TYPE "RobotStatus" AS ENUM ('IDLE', 'ACTIVE', 'ERROR');

-- CreateEnum
CREATE TYPE "MissionStatus" AS ENUM ('PENDING', 'RUNNING', 'COMPLETED');

-- CreateEnum
CREATE TYPE "EventType" AS ENUM ('CREATED', 'ASSIGNED', 'STARTED', 'COMPLETED', 'FAILED', 'CANCELLED');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "supabaseUserId" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "displayname" TEXT NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'OPERATOR',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Robot" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "status" "RobotStatus" NOT NULL DEFAULT 'IDLE',
    "createdById" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Robot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Mission" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "status" "MissionStatus" NOT NULL DEFAULT 'PENDING',
    "robotId" TEXT NOT NULL,
    "creatorId" TEXT NOT NULL,
    "updatedById" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Mission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MissionLog" (
    "id" SERIAL NOT NULL,
    "occuredAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "eventType" "EventType" NOT NULL,
    "fromStatus" "MissionStatus" NOT NULL,
    "toStatus" "MissionStatus" NOT NULL,
    "triggeredById" TEXT NOT NULL,
    "missionId" TEXT NOT NULL,

    CONSTRAINT "MissionLog_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_supabaseUserId_key" ON "User"("supabaseUserId");

-- CreateIndex
CREATE UNIQUE INDEX "User_username_key" ON "User"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Mission_robotId_key" ON "Mission"("robotId");

-- AddForeignKey
ALTER TABLE "Robot" ADD CONSTRAINT "Robot_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Mission" ADD CONSTRAINT "Mission_robotId_fkey" FOREIGN KEY ("robotId") REFERENCES "Robot"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Mission" ADD CONSTRAINT "Mission_creatorId_fkey" FOREIGN KEY ("creatorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Mission" ADD CONSTRAINT "Mission_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MissionLog" ADD CONSTRAINT "MissionLog_triggeredById_fkey" FOREIGN KEY ("triggeredById") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MissionLog" ADD CONSTRAINT "MissionLog_missionId_fkey" FOREIGN KEY ("missionId") REFERENCES "Mission"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
