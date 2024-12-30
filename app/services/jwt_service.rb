class JwtService
  SECRET_KEY = Rails.application.secret_key_base

  # トークンをエンコード
  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  # トークンをデコード
  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })[0]
    HashWithIndifferentAccess.new(body)
  rescue JWT::ExpiredSignature
    raise 'Token has expired'
  rescue JWT::DecodeError
    raise 'Invalid token'
  end
end
