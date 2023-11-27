import { Module } from '@nestjs/common';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { JwtModule } from '@nestjs/jwt';
import { UserRepository } from 'src/user/user.repository';
import { userProviders } from 'src/user/user.providers';
import { DatabaseModule } from 'src/db/database.module';
import * as dotenv from 'dotenv';
import { JwtStrategy } from './jwt.strategy';
import { PassportModule } from '@nestjs/passport/dist';
import { ImageModule } from '../image/image.module';
import { ImageService } from '../image/image.service';

dotenv.config();

@Module({
  imports: [
    DatabaseModule,
    JwtModule.register({
      secret: process.env.SECRET_KEY,
      signOptions: {
        expiresIn: 60 * 600,
      },
    }),
    PassportModule,
  ],
  controllers: [AuthController],
  providers: [...userProviders, AuthService, UserRepository, JwtStrategy, ImageService],
})
export class AuthModule {}
