class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  mount_uploader :avatar, AvatarUploader

  has_many :questions
  has_many :answers

  ROLES = %w(member admin)

  def admin?
    self.role == "admin"
  end
end
