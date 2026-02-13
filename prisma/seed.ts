import { PrismaPg } from "@prisma/adapter-pg";
import { PrismaClient } from "src/generated/prisma/client"

const adapter = new PrismaPg({ connectionString: process.env.DATABASE_URL_LOCAL! });
const prisma = new PrismaClient({adapter});
const seedUsers = [
    {
        id: "1",
        displayname: "test1",
        supabaseUserId: "1",
        username: "test1"
    },
    {
        id: "2",
        displayname: "test2",
        supabaseUserId: "2",
        username: "test2"
    },
    {
        id: "3",
        displayname: "test3",
        supabaseUserId: "3",
        username: "test3"
    }
]

async function main() {
    try {
        await prisma.user.createMany({
            data: seedUsers
        });
        console.log("Users seeded successfully");
    } catch (error) {
        console.log(error);
    }
}

main()
.then(async () => {
    await prisma.$disconnect()
})
.catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
})