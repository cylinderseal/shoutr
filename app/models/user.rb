class User < ApplicationRecord
  include Clearance::User
  has_many :shouts, dependent: :destroy
  
  has_many :likes
  has_many :liked_shouts, through: :likes, source: :shout
  
  has_many :following_relationships, foreign_key: :follower_id
  has_many :followed_users, through: :following_relationships
  
  validates :username, presence: true, uniqueness: true
  
  def to_param
    username
  end
  
  def like(shout)
    liked_shouts << shout
  end
  
  def unlike(shout)
    liked_shouts.destroy(shout)
  end
  
  def liked?(shout)
    liked_shouts.include?(shout)
  end
  
  def follow(user)
    followed_users << user
  end
  
  def unfollow(user)
    followed_users.delete(user)
  end
  
  def following?(user)
    followed_user_ids.include?(user.id)
  end
  
end
