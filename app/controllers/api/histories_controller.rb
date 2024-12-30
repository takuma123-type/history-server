class Api::HistoriesController < Api::BaseController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def create
    usecase = Api::CreateHistoryUsecase.new(
      input: Api::CreateHistoryUsecase::Input.new(
        user: current_user,
        params: history_params
      )
    )
    @output = usecase.create

    if @output.success?
      render json: @output.history, status: :created
    else
      Rails.logger.error("エラー History作成に失敗しました。: #{@output.errors}")
      render json: { error: '履歴の作成に失敗しました。', details: @output.errors }, status: :unprocessable_entity
    end
  rescue => e
    Rails.logger.error("エラー History作成中にエラーが発生しました: #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
    render json: { error: 'サーバーエラーが発生しました。' }, status: :internal_server_error
  end

  def show
    usecase = Api::GetHistoryUsecase.new(
      input: Api::GetHistoryUsecase::Input.new(
        user: current_user,
        history_id: params[:id]
      )
    )

    output = usecase.get

    if output.success?
      render json: output.history, status: :ok
    else
      render json: { errors: output.errors }, status: :not_found
    end
  rescue => e
    Rails.logger.error("Error fetching history: #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
    render json: { error: 'Internal server error' }, status: :internal_server_error
  end

  private

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last || cookies.signed[:jwt]
    decoded = JwtService.decode(token)
    @current_user = User.find(decoded[:user_id]) if decoded

    render json: { error: '認証に失敗しました' }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user
  end

  def history_params
    params.permit(
      :period,
      :company_name,
      :project_name,
      :contents,
      :others,
      position: [:id, :name],
      scale: [:id, :people],
      core_stack: [:id, :name],
      infrastructure: [:id, :name]
    )
  end
end
