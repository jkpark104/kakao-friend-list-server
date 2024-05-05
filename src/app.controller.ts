import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('/profiles/me')
  getMyProfile() {
    return this.appService.getMyProfile();
  }

  @Get('/profiles')
  getFriendProfiles() {
    return this.appService.getFriendProfiles();
  }

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }
}
