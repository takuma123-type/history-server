class Api::SignUpUsecase < Api::Usecase
  class Input
    attr_accessor :email, :password, :name

    def initialize(email:, password:, name:)
      @email = email
      @password = password
      @name = name
    end
  end

  class Output
    attr_accessor :token

    def initialize(token:)
      @token = token
    end
  end

  class SignUpError < StandardError; end

  def initialize(input:)
    @input = input
  end

  def sign_up
    raise SignUpError, "Name, email, and password are required" if @input.name.blank? || @input.email.blank? || @input.password.blank?
  
    sign_up_cell = Models::SignUpCell.new(
      email: @input.email,
      password: @input.password,
      name: @input.name
    )
  
    ActiveRecord::Base.transaction do
      authentication = create_authentication(sign_up_cell)
      user = create_user(authentication, sign_up_cell)
      token = generate_token(user)
  
      return Output.new(token: token)
    end
  rescue ActiveRecord::RecordInvalid => e
    raise SignUpError, e.message
  end
  
  private

  def create_authentication(cell)
    raise SignUpError, { errors: ['email or password is nil'] } if cell.nil? || cell.email.nil? || cell.password.nil?
  
    Authentication.create!(
      login_id: cell.email,
      password_digest: BCrypt::Password.create(cell.password)
    )
  end

  def create_user(authentication, cell)
    User.create!(
      authentication_id: authentication.id,
      name: cell.name
    )
  end

  def generate_token(user)
    secret_key = Rails.application.credentials.secret_key_base
    JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, secret_key)
  end
end
