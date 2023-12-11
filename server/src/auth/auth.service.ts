import { Injectable, Inject } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { User } from 'src/entities/user.entity';
import { idDuplicatedException } from 'src/exception/custom.exception/id.duplicate.exception';
import { profileImage } from 'src/entities/profileImage.entity';
import { invalidTokenException } from 'src/exception/custom.exception/token.invalid.exception';
import { Badge } from 'src/entities/badge.entity';
import { strToEmoji } from 'src/util/util.string.to.badge.content';
import { Repository } from 'typeorm';
import { saveImageToLocal } from '../util/util.save.image.local';
import axios from 'axios';

@Injectable()
export class AuthService {
  constructor(
    @Inject('USER_REPOSITORY')
    private userRepository: Repository<User>,
    private jwtService: JwtService,
  ) {}
  async signIn(OAuthToken: string, loginOption: number): Promise<string> {
    let userId: string;
    if (loginOption === 0) {
      userId = await this.getGithubId(OAuthToken);
    } else if (loginOption === 1) {
      userId = await this.getNaverId(OAuthToken);
    } else {
      throw new Error('Unsupported login option');
    }

    const user = await this.userRepository.findOne({ where: { oauthId: userId } });

    let accessToken = '';

    if (user) accessToken = this.jwtService.sign({ userId, userRecordId: user.userId });

    return accessToken;
  }

  async signUp(image: Express.Multer.File, OAuthToken: string, username: string, loginOption: number): Promise<string> {
    let imagePath = '';
    if (image) imagePath = await saveImageToLocal('./images/profile', image.buffer, 'profile');

    let userId: string;
    if (loginOption === 0) {
      userId = await this.getGithubId(OAuthToken);
    } else if (loginOption === 1) {
      userId = await this.getNaverId(OAuthToken);
    } else {
      throw new Error('Unsupported login option');
    }

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
    profileObj.imageUrl = imagePath;
    userObj.profileImage = Promise.resolve(profileObj);
    userObj.temperature = 0;

    const user = await this.userRepository.findOne({ where: { oauthId: userId } });

    if (user) throw new idDuplicatedException();

    await this.userRepository.save(userObj);

    const accessToken = this.jwtService.sign({ userId, userRecordId: userObj.userId });

    return accessToken;
  }

  async getGithubId(token: string): Promise<string> {
    try {
      const response = await axios.get('https://api.github.com/user', {
        headers: {
          Authorization: `token ${token}`,
        },
      });
      return response.data.id;
    } catch (error) {
      throw new invalidTokenException();
    }
  }

  async getNaverId(token: string): Promise<string> {
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

  async checkDuplicated(nickname: string) {
    const userByNickname = await this.userRepository.findOne({ where: { username: nickname } });
    if (userByNickname) throw new idDuplicatedException();
    return;
  }
}
