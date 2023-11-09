import { Injectable } from '@nestjs/common';
import { UserRepository } from './../user/user.repository';
import { JwtService } from '@nestjs/jwt';
import { User } from 'src/entities/user.entity';

@Injectable()
export class AuthService {
  constructor(
    private userRepository: UserRepository,
    private jwtService: JwtService,
  ) {}
  async signIn(OAuthToken: string): Promise<string> {
    const userId = await this.getId(OAuthToken);

    const user = await this.userRepository.findOneById(userId);

    let accessToken = '';

    if (user) accessToken = this.jwtService.sign({ userId });

    return accessToken;
  }

  async signUp(OAuthToken: string, username: string): Promise<string> {
    const userId = await this.getId(OAuthToken);

    const userObj = new User();
    userObj.username = username;
    userObj.oauthId = userId;
    userObj.profileImageURL = '';
    userObj.temperature = 0;

    this.userRepository.createUser(userObj);

    const accessToken = this.jwtService.sign({ userId });

    return accessToken;
  }

  async getId(token: string): Promise<string> {
    const header = 'Bearer ' + token;
    const api_url = 'https://openapi.naver.com/v1/nid/me';

    const response = await fetch(api_url, {
      method: 'GET',
      headers: {
        Authorization: header,
      },
    });
    const responseJson = await response.json();
    return responseJson.response.id;
  }
}
