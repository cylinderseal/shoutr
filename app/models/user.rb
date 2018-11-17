class User < ApplicationRecord
  has_many :shouts, dependent: :destroy
  include Clearance::User
  
  validates :username, presence: true, uniqueness: true
end
