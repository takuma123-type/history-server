class Api::SessionsController < Api::BaseController
  skip_before_action :verify_authenticity_token, only: [:sign_up]

  def sign_up
    input = Api::SignUpUsecase::Input.new(
      email: session_params[:email],
      password: session_params[:password],
      name: session_params[:name]
    )

    usecase = Api::SignUpUsecase.new(input: input)
    output = usecase.sign_up

    render json: { token: output.token }, status: :created
  rescue Api::SignUpUsecase::SignUpError => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :name)
  end
end
