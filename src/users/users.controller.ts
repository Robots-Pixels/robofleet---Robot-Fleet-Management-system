import { Body, Controller, Get } from '@nestjs/common';
import { UsersService } from './users.service';
import { SafeUser } from './interfaces/user.interface';

@Controller('users')
export class UsersController {
    constructor(private usersService: UsersService){}

    @Get()
    async findAll(): Promise<SafeUser[]> {
        return this.usersService.findAll();
    }

}
