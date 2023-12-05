import { Story } from '../entities/story.entity';
import { saveImageToLocal } from './util.save.image.local';
import { StoryImage } from '../entities/storyImage.entity';
import { dateFormatToISO8601 } from './util.date.format.to.ISO8601';

export const updateStory = async (story: Story, { title, content, category, place, images, badge, date }) => {
  const savedImagePaths = await Promise.all(images.map(async (image: Express.Multer.File) => saveImageToLocal('./images/story', image.buffer, 'story')));
  story.title = title;
  story.content = content;
  story.category = category;
  story.place = place;
  story.badge = badge;
  story.createAt = dateFormatToISO8601(date);

  story.storyImages = Promise.resolve(
    savedImagePaths.map((path) => {
      const storyImageObj = new StoryImage();
      storyImageObj.imageUrl = path;
      return storyImageObj;
    }),
  );

  return story;
};
