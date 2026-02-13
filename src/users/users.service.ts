import { Injectable } from '@nestjs/common';
import { SafeUser } from './interfaces/user.interface';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class UsersService {
    constructor(private prisma: PrismaService){}
    
    async findAll(): Promise<SafeUser[]>{
        const users = await this.prisma.user.findMany({
            select: {
                id: true,
                username: true,
                role: true,
            }
        });
        return users;
    }

    async create(){

    }
}
