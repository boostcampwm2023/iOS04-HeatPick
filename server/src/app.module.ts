import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { DatabaseModule } from './db/database.module';
import { AuthModule } from './auth/auth.module';
import { StoryModule } from './story/story.module';

@Module({
  imports: [DatabaseModule, AuthModule, StoryModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
