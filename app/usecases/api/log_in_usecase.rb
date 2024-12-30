class Api::LogInUsecase < Api::Usecase
  class Input
    attr_accessor :email, :password

    def initialize(email:, password:)
      @email = email
      @password = password
    end
  end

  class Output
    attr_accessor :token

    def initialize(token:)
      @token = token
    end
  end

  class LogInError < StandardError; end

  def initialize(input:)
    @input = input
  end

  def log_in
    user = find_user_by_email(@input.email)
    raise LogInError, "Invalid email or password" unless authenticate_user(user, @input.password)

    token = JwtService.encode({ user_id: user.id, exp: 24.hours.from_now.to_i })
    Output.new(token: token)
  rescue ActiveRecord::RecordNotFound
    raise LogInError, "User not found"
  end

  private

  def find_user_by_email(email)
    authentication = Authentication.find_by!(login_id: email)
    User.find_by!(authentication_id: authentication.id)
  end

  def authenticate_user(user, password)
    BCrypt::Password.new(user.authentication.password_digest) == password
  rescue BCrypt::Errors::InvalidHash
    false
  end
end
