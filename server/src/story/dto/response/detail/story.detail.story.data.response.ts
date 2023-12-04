import { ApiProperty } from '@nestjs/swagger';
import { StoryDetailPlaceDataResponseDto } from './story.detail.place.data.response.dto';
import { Story } from '../../../../entities/story.entity';
import { removeMillisecondsFromISOString } from '../../../../util/util.date.format.to.ISO8601';
import { StoryImage } from '../../../../entities/storyImage.entity';
import { strToEmoji, strToExplain } from '../../../../util/util.string.to.badge.content';

export class StoryDetailStoryDataResponseDto {
  @ApiProperty()
  storyId: number;

  @ApiProperty()
  createdAt: string;

  @ApiProperty()
  category: string;

  @ApiProperty()
  storyImageURL: string[];

  @ApiProperty()
  title: string;

  @ApiProperty()
  badgeName: string;

  @ApiProperty()
  badgeDescription: string;

  @ApiProperty()
  likeState: number;

  @ApiProperty()
  likeCount: number;

  @ApiProperty()
  commentCount: number;

  @ApiProperty()
  content: string;

  @ApiProperty()
  place: StoryDetailPlaceDataResponseDto;
}

export const getStoryDetailStoryDataResponseDto = async (story: Story, userId: number, placeDto: StoryDetailPlaceDataResponseDto): Promise<StoryDetailStoryDataResponseDto> => {
  return {
    storyId: story.storyId,
    createdAt: removeMillisecondsFromISOString(story.createAt.toISOString()),
    category: story.category.categoryName,
    storyImageURL: (await story.storyImages).map((storyImage: StoryImage) => storyImage.imageUrl),
    title: story.title,
    badgeName: `${strToEmoji[story.badge?.badgeName]}${story.badge?.badgeName}`,
    badgeDescription: strToExplain[`${story.badge?.badgeName}`],
    likeState: (await story.usersWhoLiked).some((user) => user.userId === userId) ? 0 : 1,
    likeCount: story.likeCount,
    commentCount: story.commentCount,
    content: story.content,
    place: placeDto,
  };
};
