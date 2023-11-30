import { ApiProperty } from '@nestjs/swagger';
import { CommentViewData } from './comment.view.data';

export class CommentViewResponseDto {
  @ApiProperty({ type: () => [CommentViewData] })
  comments: CommentViewData[];
}
