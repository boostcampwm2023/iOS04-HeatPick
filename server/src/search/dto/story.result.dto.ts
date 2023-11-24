import { ApiProperty } from '@nestjs/swagger';

export class StoryResultDto {
  @ApiProperty({ description: '스토리의 제목' })
  title: string;

  @ApiProperty({ description: '스토리의 내용' })
  content: string;

  @ApiProperty({ description: '좋아요 수' })
  likeCount: number;

  @ApiProperty({ description: '댓글 수' })
  commentCount: number;

  @ApiProperty({ description: '게시물이 생성된 시간' })
  createdAt: Date;

  @ApiProperty({ description: '스토리에 있는 이미지의 URL' })
  storyImages: String[];
}
