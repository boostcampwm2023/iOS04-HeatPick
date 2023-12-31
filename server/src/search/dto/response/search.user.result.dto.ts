import { ApiProperty } from '@nestjs/swagger';
import { UserResultDto } from './user.result.dto';

export class SearchUserResultDto {
  @ApiProperty({ description: '유저 배열', type: UserResultDto, isArray: true })
  users: UserResultDto[];

  @ApiProperty({ description: '마지막 페이지인지 여부', type: Boolean })
  isLastPage: boolean;
}
