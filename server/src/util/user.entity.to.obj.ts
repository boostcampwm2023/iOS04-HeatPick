import { User } from 'src/entities/user.entity';

export async function userEntityToUserObj(user: User) {
  const userImage = await user.profileImage;
  return {
    userId: user.userId,
    username: user.username,
    profileUrl: userImage ? userImage.imageUrl : '',
  };
}
