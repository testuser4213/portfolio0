#
# Post
#
#  + title: string
#  + body: string
#

class Post < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true
  validates :body, presence: true

  def str_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def str_tags
    self.tags.map(&:name).join(', ')
  end

  def self.tagged_with(tag)
    Tag.find_by_name!(tag).posts
  end

  def self.recent_posts(count)
    self.order(created_at: :desc).limit(count).each do |post|
      yield post
    end
  end
end
