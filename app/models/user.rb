class User < ApplicationRecord
  include Clearance::User
  has_many :shouts, dependent: :destroy
  
  has_many :likes
  has_many :liked_shouts, through: :likes, source: :shout
  
  has_many :followed_user_relationships, foreign_key: :follower_id,
                                         class_name: "FollowingRelationship",
                                         dependent: :destroy
  has_many :followed_users, through: :followed_user_relationships
  
  has_many :follower_relationships, foreign_key: :followed_user_id, 
                                    class_name: "FollowingRelationship", 
                                    dependent: :destroy
  has_many :followers, through: :follower_relationships
  
  validates :username, presence: true, uniqueness: true
  
  def to_param
    username
  end
  
  # Like
  def like(shout)
    liked_shouts << shout
  end
  
  def unlike(shout)
    liked_shouts.destroy(shout)
  end
  
  def liked?(shout)
    liked_shouts.include?(shout)
  end
  
  # Follow
  def follow(user)
    followed_users << user
  end
  
  def unfollow(user)
    followed_users.delete(user)
  end
  
  def following?(user)
    followed_user_ids.include?(user.id)
  end
  
  # Counter Cache
  
end
