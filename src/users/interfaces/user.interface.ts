import { Prisma } from "src/generated/prisma/client";
import { Role } from "../enums/users.enum";

export type SafeUser = Prisma.UserGetPayload<{
    select: {
        id: true,
        username: true,
        role: true
    }
}>