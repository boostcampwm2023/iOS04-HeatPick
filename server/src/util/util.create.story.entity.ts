import { Story } from '../entities/story.entity';
import { StoryImage } from '../entities/storyImage.entity';
import { saveImageToLocal } from './util.save.image.local';

export const createStoryEntity = async ({ title, content, images, date }) => {
  const savedImagePaths = await Promise.all(images.map(async (image: Express.Multer.File) => saveImageToLocal('../../uploads', image.buffer)));
  const story = new Story();
  story.title = title;
  story.content = content;
  const storyImageArr = await story.storyImages;
  savedImagePaths.forEach((path) => {
    const storyImageObj = new StoryImage();
    storyImageObj.imageUrl = path;
    storyImageArr.push(storyImageObj);
  });
  story.createAt = new Date();
  story.likeCount = 0;

  return story;
};
