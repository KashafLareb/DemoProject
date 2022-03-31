class JsonWebToken

  def self.encode(payload)
    JWT.encode(payload, nil)
  end

  def self.decode(token)
    HashWithIndifferentAccess.new(JWT.decode(token, nil, false)[0])
  rescue JWT::ExpiredSignature
    "Token Expired"
  rescue
    nil
  end
end
