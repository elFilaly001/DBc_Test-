class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :email, type: String
  field :password_digest, type: String
  
  # Add validations
  validates :email, presence: true, uniqueness: true , format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, on: :create
  
  # Add secure password functionality
  include ActiveModel::SecurePassword
  has_secure_password
end
