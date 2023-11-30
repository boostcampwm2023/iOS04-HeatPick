import { Story } from 'src/entities/story.entity';
import { userEntityToUserObj } from './user.entity.to.obj';
import { StoryResultDto } from 'src/search/dto/story.result.dto';

export async function storyEntityToObjWithOneImg(story: Story): Promise<StoryResultDto> {
  const images = await story.storyImages;
  const urls = await Promise.all(images.map(async (image) => image.imageUrl));
  const place = await story.place;
  const userEntity = await story.user;
  const user = userEntityToUserObj(userEntity);
  const categoryId = story.category ? story.category.categoryId : 0;

  return {
    storyId: story.storyId,
    title: story.title,
    content: story.content,
    likeCount: story.likeCount,
    commentCount: story.commentCount,
    storyImage: urls[0],
    categoryId: categoryId,
    user: user,
    latitude: place.latitude,
    longitude: place.longitude,
  };
}

export async function storyEntityToObj(story: Story) {
  const images = await story.storyImages;
  const categoryId = story.category ? story.category.categoryId : 0;
  const userEntity = await story.user;
  const user = userEntityToUserObj(userEntity);
  const urls = images.map((image) => image.imageUrl);
  const place = await story.place;
  return {
    storyId: story.storyId,
    title: story.title,
    content: story.content,
    likeCount: story.likeCount,
    commentCount: story.commentCount,
    storyImages: urls,
    categoryId: categoryId,
    user: user,
    latitude: place.latitude,
    longitude: place.longitude,
  };
}
