import { Story } from '../entities/story.entity';
import { StoryImage } from '../entities/storyImage.entity';
import { saveImageToLocal } from './util.save.image.local';
import { dateFormatToISO8601 } from './util.date.format.to.ISO8601';

export const createStoryEntity = async ({ title, content, category, place, images, badge, date }) => {
  const savedImagePaths = await Promise.all(images.map(async (image: Express.Multer.File) => saveImageToLocal('./images/story', image.buffer, 'story')));
  const story = new Story();
  story.title = title;
  story.content = content;
  story.category = category;
  story.place = place;
  story.createAt = dateFormatToISO8601(date);
  story.likeCount = 0;
  story.commentCount = 0;
  const storyImageArr = await story.storyImages;
  savedImagePaths.forEach((path) => {
    const storyImageObj = new StoryImage();
    storyImageObj.imageUrl = path;
    storyImageArr.push(storyImageObj);
  });
  story.badge = badge;
  return story;
};
