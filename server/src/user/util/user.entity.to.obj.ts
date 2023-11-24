import { User } from 'src/entities/user.entity';

export function userEntityToUserObj(user: User) {
  return {
    userId: user.userId,
    username: user.username,
    profileUrl: user.profileImage.imageUrl,
  };
}
