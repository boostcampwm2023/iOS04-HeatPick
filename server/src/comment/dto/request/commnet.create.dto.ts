import { ApiProperty } from '@nestjs/swagger';
import { ArrayUnique, IsArray, IsNotEmpty, IsNumber } from 'class-validator';
import { Transform } from 'class-transformer';

export class CreateCommentDto {
  @ApiProperty({ example: '11', description: '스토리 아이디' })
  @IsNotEmpty({ message: 'storyId는 필수입니다.' })
  @Transform(({ value }) => parseInt(value, 10)) // 문자열을 숫자로 변환
  @IsNumber()
  storyId: number;

  @ApiProperty({ example: '안녕하세용', description: '댓글 내용' })
  @IsNotEmpty({ message: 'content 필수입니다.' })
  content: string;

  @ApiProperty({ example: '[1, 2, 3]', description: '멘션된 유저 아이디 리스트' })
  @IsArray()
  @ArrayUnique((id) => id, { message: 'mentions에 중복된 유저 아이디가 포함되어 있습니다.' })
  @Transform(({ value }) => value.map(Number))
  @IsNumber({}, { each: true, message: 'mentions 배열의 각 요소는 유저 아이디여야 합니다.' })
  mentions: number[];
}
