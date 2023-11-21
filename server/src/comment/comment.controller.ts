import { Body, Controller, Post } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { CreateCommentDto } from './dto/commnet.create.dto';
import { CommentService } from './comment.service';

@ApiTags('comment')
@Controller('comment')
export class CommentController {
  constructor(private commentService: CommentService) {}

  @Post('create')
  @ApiOperation({ summary: '댓글 생성 API' })
  @ApiResponse({ status: 200, description: 'commentId' })
  async create(@Body() createCommentDto: CreateCommentDto) {
    const { storyId, content } = createCommentDto;
    return this.commentService.create({ storyId, content });
  }
}
