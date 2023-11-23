import { ApiProperty } from '@nestjs/swagger';

export class userDataInStoryView {
  @ApiProperty()
  userId: number;

  @ApiProperty()
  username: string;

  @ApiProperty()
  profileImageUrl: string;
  //badge: string;
}
