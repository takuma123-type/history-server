class Api::CoreStacksController < Api::BaseController
  skip_before_action :verify_authenticity_token

  def index
    usecase = Api::FetchCoreStacksUsecase.new(
      input: Api::FetchCoreStacksUsecase::Input.new
    )
    @output = usecase.fetch

    render json: @output.corestacks, status: :ok
  rescue => e
    Rails.logger.error("Error in CoreStacksController#index: #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
    render json: { error: '取得できませんでした。' }, status: :internal_server_error
  end
end
