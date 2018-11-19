class User < ApplicationRecord
  include Clearance::User
  has_many :shouts, dependent: :destroy
  has_many :likes
  has_many :liked_shouts, through: :likes, source: :shout
  
  validates :username, presence: true, uniqueness: true
  
  def like(shout)
    liked_shouts << shout
  end
  
  def unlike(shout)
    liked_shouts.destroy(shout)
  end
  
  def liked?(shout)
    liked_shouts.include?(shout)
  end
  
  
end
