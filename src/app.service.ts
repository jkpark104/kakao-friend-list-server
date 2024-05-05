import { Injectable } from '@nestjs/common';
import { friendProfiles, myProfile } from 'src/mocks/data';

@Injectable()
export class AppService {
  getMyProfile() {
    return myProfile;
  }

  getFriendProfiles() {
    return friendProfiles;
  }

  getHello(): string {
    return 'Hello World!';
  }
}
