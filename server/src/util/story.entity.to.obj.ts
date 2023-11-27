import { Story } from 'src/entities/story.entity';

export async function storyEntityToObjWithOneImg(story: Story) {
  const images = await story.storyImages;
  const urls = await Promise.all(images.map(async (image) => image.imageUrl));
  const categoryId = story.category ? story.category.categoryId : 0;

  return { storyId: story.storyId, title: story.title, content: story.content, likeCount: story.likeCount, commentCount: story.commentCount, storyImage: urls[0], categoryId: categoryId };
}

export async function storyEntityToObj(story: Story) {
  const images = await story.storyImages;
  const categoryId = story.category ? story.category.categoryId : 0;
  const urls = images.map((image) => image.imageUrl);
  return { storyId: story.storyId, title: story.title, content: story.content, likeCount: story.likeCount, commentCount: story.commentCount, storyImages: urls, categoryId: categoryId };
}
