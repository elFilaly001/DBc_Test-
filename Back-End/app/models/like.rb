class Like
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :question

  # Index for performance and to enforce uniqueness
  index({ user_id: 1, question_id: 1 }, { unique: true })

  validates :user_id, uniqueness: { scope: :question_id }
end