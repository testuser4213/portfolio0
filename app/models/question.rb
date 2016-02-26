#
# Question
#
#  + title: string
#  + body: text
#  + closed: boolean
#

class Question < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  def closed?
    closed
  end

  def open?
    !closed
  end

  def self.recent_questions(count)
    self.select('questions.*, count(answers.question_id) as count')
        .joins("LEFT JOIN answers ON answers.question_id = questions.id")
        .group('questions.id')
        .includes(:post)
        .order('created_at DESC')
        .limit(count).
        each do |question|
      yield question
    end
  end
end
