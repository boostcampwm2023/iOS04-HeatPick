import { Story } from 'src/entities/story.entity';

export async function storyEntityToObjWithOneImg(story: Story) {
  const images = await story.storyImages;

  const urls = await Promise.all(images.map(async (image) => image.imageUrl));

  return { id: story.storyId, title: story.title, content: story.content, likeCount: story.likeCount, commentCount: story.commentCount, storyImage: urls[0] };
}

export async function storyEntityToObj(story: Story) {
  const images = await story.storyImages;
  const urls = images.map((image) => image.imageUrl);
  return { id: story.storyId, title: story.title, content: story.content, likeCount: story.likeCount, commentCount: story.commentCount, storyImages: urls };
}
