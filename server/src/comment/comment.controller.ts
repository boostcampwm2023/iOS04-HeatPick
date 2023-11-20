import { Body, Controller, Post } from '@nestjs/common';
import { ApiOperation, ApiResponse } from '@nestjs/swagger';
import { CreateCommentDto } from './dto/commnet.create.dto';
import { CommentService } from './comment.service';

@Controller('comment')
export class CommentController {
  constructor(private commentService: CommentService) {}

  @Post('create')
  @ApiOperation({ summary: 'Create Comment' })
  @ApiResponse({ status: 200, description: 'commentId' })
  async create(@Body() createCommentDto: CreateCommentDto) {
    const { storyId, content } = createCommentDto;
    return this.commentService.create({ storyId, content });
  }
}
