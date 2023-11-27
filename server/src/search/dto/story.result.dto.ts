import { ApiProperty } from '@nestjs/swagger';

export class StoryResultDto {
  @ApiProperty({ description: 'user id' })
  id: number;

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
}
