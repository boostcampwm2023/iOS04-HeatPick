import { ApiProperty } from '@nestjs/swagger';
import { User } from '../../../../entities/user.entity';

export class StoryDetailUserDataResponseDto {
  @ApiProperty()
  userId: number;

  @ApiProperty()
  username: string;

  @ApiProperty()
  profileImageUrl: string;

  @ApiProperty()
  status: number; //0 본인 1 언팔 2 팔로우
}

export const getStoryDetailUserDataResponseDto = async (targetUser: User, requestUserId: number): Promise<StoryDetailUserDataResponseDto> => {
  const userImage = await targetUser.profileImage;
  return {
    userId: targetUser.userId,
    username: targetUser.username,
    profileImageUrl: userImage.imageUrl,
    status: requestUserId === targetUser.userId ? 0 : targetUser.followers.some((follower) => follower.userId === requestUserId) ? 2 : 1,
  };
};
