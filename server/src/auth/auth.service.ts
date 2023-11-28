import { Injectable } from '@nestjs/common';
import { UserRepository } from './../user/user.repository';
import { JwtService } from '@nestjs/jwt';
import { User } from 'src/entities/user.entity';
import { idDuplicatedException } from 'src/exception/custom.exception/id.duplicate.exception';
import { profileImage } from 'src/entities/profileImage.entity';
import { ImageService } from '../image/image.service';
import { invalidTokenException } from 'src/exception/custom.exception/token.invalid.exception';
import { Badge } from 'src/entities/badge.entity';
import { strToEmoji } from 'src/util/util.string.to.emoji';

@Injectable()
export class AuthService {
  constructor(
    private userRepository: UserRepository,
    private imageService: ImageService,
    private jwtService: JwtService,
  ) {}
  async signIn(OAuthToken: string): Promise<string> {
    const userId = await this.getId(OAuthToken);

    const user = await this.userRepository.findOneById(userId);

    let accessToken = '';

    if (user) accessToken = this.jwtService.sign({ userId, userRecordId: user.userId });

    return accessToken;
  }

  async signUp(image: Express.Multer.File, OAuthToken: string, username: string): Promise<string> {
    let imagePath = '';
    if (image) imagePath = await this.imageService.saveImage('./images/profile', image.buffer);

    const userId = await this.getId(OAuthToken);

    const userObj = new User();
    userObj.username = username;
    userObj.oauthId = userId;

    const newBadge = new Badge();
    newBadge.badgeExp = 0;
    newBadge.badgeName = '뉴비';
    newBadge.emoji = strToEmoji[newBadge.badgeName];
    newBadge.representativeUser = userObj;

    const userBadges = await userObj.badges;
    userBadges.push(newBadge);

    const profileObj = new profileImage();
    profileObj.imageUrl = `https://server.bc8heatpick.store/image/profile?name=${imagePath}`;
    userObj.profileImage = profileObj;
    userObj.temperature = 0;

    const user = await this.userRepository.findOneById(userId);

    if (user) throw new idDuplicatedException();

    await this.userRepository.createUser(userObj);

    const accessToken = this.jwtService.sign({ userId, userRecordId: userObj.userId });

    return accessToken;
  }

  async getId(token: string): Promise<string> {
    const header = 'Bearer ' + token;
    const api_url = 'https://openapi.naver.com/v1/nid/me';
    try {
      const response = await fetch(api_url, {
        method: 'GET',
        headers: {
          Authorization: header,
        },
      });
      const responseJson = await response.json();
      return responseJson.response.id;
    } catch (error) {
      throw new invalidTokenException();
    }
  }
}
