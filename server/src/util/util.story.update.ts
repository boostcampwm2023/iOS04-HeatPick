import { Story } from '../entities/story.entity';
import { saveImageToLocal } from './util.save.image.local';
import { StoryImage } from '../entities/storyImage.entity';

export const updateStory = async (story: Story, { title, content, category, place, images, badge }) => {
  const savedImageNames = await Promise.all(images.map(async (image: Express.Multer.File) => saveImageToLocal('./images/story', image.buffer)));
  story.title = title;
  story.content = content;
  story.category = category;
  story.place = place;
  story.badge = badge;

  story.storyImages = Promise.resolve(
    savedImageNames.map((name) => {
      const storyImageObj = new StoryImage();
      storyImageObj.imageUrl = `https://server.bc8heatpick.store/image/story?name=${name}`;
      return storyImageObj;
    }),
  );

  return story;
};
