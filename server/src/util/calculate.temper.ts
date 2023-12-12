import { User } from 'src/entities/user.entity';

export async function calculateTemperature(user: User): Promise<number> {
  const weight = {
    story: 0.2,
    like: 0.3,
    comment: 0.2,
    follower: 0.3,
  };

  const stories = await user.stories;
  const comments = await user.comments;
  const followers = user.followers.length;

  const storiesCount = stories.length;

  let totalLikes = 0;
  let totalComments = comments.length;
  stories.forEach((story) => {
    totalLikes += story.likeCount;
  });

  const storyScore = storiesCount * weight.story;
  const likeScore = totalLikes * weight.like;
  const commentScore = totalComments * weight.comment;
  const followerScore = followers * weight.follower;

  let totalScore = storyScore + likeScore + commentScore + followerScore;

  return totalScore > 100 ? 100 : totalScore;
}
