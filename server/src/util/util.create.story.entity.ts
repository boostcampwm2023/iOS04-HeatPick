import { Story } from '../entities/story.entity';
import { StoryImage } from '../entities/storyImage.entity';
import { saveImageToLocal } from './util.save.image.local';
import { dateFormatToISO8601 } from './util.date.format.to.ISO8601';
import { Category } from '../entities/category.entity';
import { Badge } from '../entities/badge.entity';

export const createStoryEntity = async ({ title, content, category, place, images, badge, date }) => {
  const savedImageNames = await Promise.all(images.map(async (image: Express.Multer.File) => saveImageToLocal('./images/story', image.buffer)));
  const story = new Story();
  story.title = title;
  story.content = content;
  const categoryObj = new Category();
  categoryObj.categoryName = category;
  story.category = categoryObj;
  story.place = place;
  story.createAt = dateFormatToISO8601(date);
  story.likeCount = 0;
  story.commentCount = 0;
  const storyImageArr = await story.storyImages;
  savedImageNames.forEach((name) => {
    const storyImageObj = new StoryImage();
    storyImageObj.imageUrl = name;
    storyImageArr.push(storyImageObj);
  });
  story.badge = badge;
  return story;
};
