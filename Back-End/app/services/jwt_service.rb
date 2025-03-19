class JwtService
  # Use credentials instead of secrets in Rails 8.0+
  SECRET_KEY = Rails.application.credentials.secret_key_base || ENV['SECRET_KEY_BASE'] || 'development_secret'
  ALGORITHM = 'HS256'
  EXPIRY = 24.hours.to_i
  
  def self.encode(payload)
    # Add expiration time and ensure data is stringified
    payload = payload.transform_keys(&:to_s)
    payload['exp'] = Time.now.to_i + EXPIRY
    JWT.encode(payload, SECRET_KEY, ALGORITHM)
  end

  def self.decode(token)
    # Return the decoded payload as a HashWithIndifferentAccess
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: ALGORITHM })[0]
    ActiveSupport::HashWithIndifferentAccess.new(decoded)
  rescue JWT::DecodeError => e
    Rails.logger.error "JWT decode error: #{e.message}"
    raise e
  end
end