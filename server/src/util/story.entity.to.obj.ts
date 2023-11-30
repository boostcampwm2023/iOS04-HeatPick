import { Story } from 'src/entities/story.entity';
import { userEntityToUserObj } from './user.entity.to.obj';

export async function storyEntityToObjWithOneImg(story: Story) {
  const images = await story.storyImages;
  const urls = await Promise.all(images.map(async (image) => image.imageUrl));
  const userEntity = await story.user;
  const user = userEntityToUserObj(userEntity);
  const categoryId = story.category ? story.category.categoryId : 0;

  return { storyId: story.storyId, title: story.title, content: story.content, likeCount: story.likeCount, commentCount: story.commentCount, storyImage: urls[0], categoryId: categoryId, user: user };
}

export async function storyEntityToObj(story: Story) {
  const images = await story.storyImages;
  const categoryId = story.category ? story.category.categoryId : 0;
  const userEntity = await story.user;
  const user = userEntityToUserObj(userEntity);
  const urls = images.map((image) => image.imageUrl);
  return { storyId: story.storyId, title: story.title, content: story.content, likeCount: story.likeCount, commentCount: story.commentCount, storyImages: urls, categoryId: categoryId, user: user };
}
