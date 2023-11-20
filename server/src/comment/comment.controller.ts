import { Body, Controller, Patch, Post, ValidationPipe } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { CreateCommentDto } from './dto/commnet.create.dto';
import { CommentService } from './comment.service';
import { UpdateCommentDto } from './dto/comment.update.dto';

@ApiTags('comment')
@Controller('comment')
export class CommentController {
  constructor(private commentService: CommentService) {}

  @Post('create')
  @ApiOperation({ summary: '댓글 생성 API' })
  @ApiResponse({ status: 201, description: 'commentId' })
  async create(@Body(new ValidationPipe({ transform: true })) createCommentDto: CreateCommentDto) {
    const { storyId, content } = createCommentDto;
    return this.commentService.create({ storyId, content });
  }

  @Patch('update')
  @ApiOperation({ summary: '댓글 수정 API' })
  @ApiResponse({ status: 201, description: 'commentId' })
  async update(@Body(new ValidationPipe({ transform: true })) updateCommentDto: UpdateCommentDto) {
    const { storyId, commentId, content } = updateCommentDto;

    return this.commentService.update({ storyId, commentId, content });
  }
}
