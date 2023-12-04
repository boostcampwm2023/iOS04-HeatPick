import { Body, Controller, Delete, Get, Patch, Post, Query, UseGuards, ValidationPipe, Request, ParseIntPipe } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';
import { CreateCommentDto } from './dto/request/commnet.create.dto';
import { CommentService } from './comment.service';
import { UpdateCommentDto } from './dto/request/comment.update.dto';
import { DeleteCommentDto } from './dto/request/comment.delete.dto';
import { JwtAuthGuard } from '../auth/jwt.guard';
import { MentionableResponseDto } from './dto/response/comment.mentionable.response.dto';
import { CommentViewResponseDto } from './dto/response/comment.view.response.dto';

@ApiTags('comment')
@Controller('comment')
@UseGuards(JwtAuthGuard)
export class CommentController {
  constructor(private commentService: CommentService) {}

  @Get('mentionable')
  @ApiOperation({ summary: '멘션할 유저를 불러오는 API' })
  @ApiResponse({ status: 201, description: '멘션 가능한 유저의 리스트', type: MentionableResponseDto })
  async mentions(@Request() req: any, @Query('storyId', ParseIntPipe) storyId: number) {
    const userId = req.user.id;
    return { mentionables: await this.commentService.getMentionable({ storyId, userId }) };
  }

  @Post('create')
  @ApiOperation({ summary: '댓글 생성 API' })
  @ApiResponse({
    status: 200,
    description: '생성된 댓글 id',
    schema: {
      type: 'object',
      properties: {
        commentId: { type: 'number' },
      },
    },
  })
  async create(@Request() req: any, @Body(new ValidationPipe({ transform: true })) createCommentDto: CreateCommentDto) {
    const { storyId, content, mentions } = createCommentDto;
    const userId = req.user.userRecordId;
    return this.commentService.create({ storyId, userId, content, mentions });
  }

  @Get('read')
  @ApiOperation({ summary: '댓글 조회 API' })
  @ApiResponse({ status: 201, description: '댓글 목록', type: CommentViewResponseDto })
  async read(@Request() req: any, @Query('storyId', ParseIntPipe) storyId: number) {
    const userId = req.user.userRecordId;
    return this.commentService.read(storyId, userId);
  }

  @Patch('update')
  @ApiOperation({ summary: '댓글 수정 API' })
  @ApiResponse({ status: 201, description: 'commentId' })
  async update(@Request() req: any, @Body(new ValidationPipe({ transform: true })) updateCommentDto: UpdateCommentDto) {
    const { storyId, commentId, content, mentions } = updateCommentDto;
    const userId = req.user.id;
    return this.commentService.update({ storyId, userId, commentId, content, mentions });
  }

  @Delete('delete')
  @ApiOperation({ summary: '댓글 삭제 API' })
  @ApiResponse({ status: 201 })
  async delete(@Query(new ValidationPipe({ transform: true })) deleteCommentDto: DeleteCommentDto) {
    const { storyId, commentId } = deleteCommentDto;
    return this.commentService.delete({ storyId, commentId });
  }
}
