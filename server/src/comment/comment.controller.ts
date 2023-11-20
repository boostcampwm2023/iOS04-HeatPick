import { Controller, Post } from '@nestjs/common';
import { ApiOperation, ApiResponse } from '@nestjs/swagger';
import { CreateCommentDto } from './dto/commnet.create.dto';

@Controller('comment')
export class CommentController {
  constructor(private commentService: CommentService) {}

  @Post('create')
  @ApiOperation({ summary: 'Create Comment' })
  @ApiResponse({ status: 200, description: 'commentId' })
  async create(createCommentDto: CreateCommentDto) {
    const { content } = createCommentDto;
    return this.commentService.create({ content });
  }
}