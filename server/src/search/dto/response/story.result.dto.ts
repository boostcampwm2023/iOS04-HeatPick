import { ApiProperty } from '@nestjs/swagger';
import { UserResultDto } from './user.result.dto';

export class StoryResultDto {
  @ApiProperty({ description: 'user id' })
  storyId: number;

  @ApiProperty({ description: '스토리의 제목' })
  title: string;

  @ApiProperty({ description: '스토리의 내용' })
  content: string;

  @ApiProperty({ description: '좋아요 수' })
  likeCount: number;

  @ApiProperty({ description: '댓글 수' })
  commentCount: number;

  @ApiProperty({ description: '스토리에 있는 이미지의 URL' })
  storyImage: String;

  @ApiProperty({ description: '카테고리의 id' })
  categoryId: number;

  @ApiProperty({ description: '스토리를 작성한 유저 정보', type: () => UserResultDto })
  user: UserResultDto;

  @ApiProperty({ description: '스토리의 latitude' })
  latitude: number;

  @ApiProperty({ description: '스토리의 longitude' })
  longitude: number;
}

export class StoryRecommendResponseDto {
  @ApiProperty({ description: 'StoryResultDto 배열', type: StoryResultDto, isArray: true })
  recommededStories: StoryResultDto[];

  @ApiProperty({ description: '마지막 페이지인지 여부' })
  isLastPage: boolean;
}
