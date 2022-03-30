class JsonWebToken
  def self.encode(payload)
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
  def self.decode(token)
    HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.credentials.secret_key_base)[0])
  rescue JWT::ExpiredSignature
    "Token Expired"
  rescue
    nil
  end
end
