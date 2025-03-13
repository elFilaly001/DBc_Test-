class Question
  include Mongoid::Document
  include Mongoid::Timestamps


  field: title, type: String
  field: content, type: String
  field: location, type: String

  validates :title, presence: true
  validates :content, presence: true
  validates :location, presence: true
end
