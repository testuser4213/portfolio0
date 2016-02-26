#
# Tag
#
#  + name: string
#

class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings

  def self.counted
    self.select('name, count(taggings.tag_id) as count').joins(:taggings).group('tags.name')
  end
end
