import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber } from 'class-validator';
import { Transform } from 'class-transformer';

export class CreateCommentDto {
  @ApiProperty({ example: '11', description: 'story id' })
  @IsNotEmpty({ message: 'storyId는 필수입니다.' })
  @Transform(({ value }) => parseInt(value, 10)) // 문자열을 숫자로 변환
  @IsNumber()
  storyId: number;

  @ApiProperty({ example: 'my comment', description: 'comment content' })
  content: string;
}
