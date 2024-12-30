class Api::InfrastructuresController < Api::BaseController
  skip_before_action :verify_authenticity_token

  def index
    usecase = Api::FetchInfrastructuresUsecase.new(
      input: Api::FetchInfrastructuresUsecase::Input.new
    )
    @output = usecase.fetch

    render json: @output.infrastructures, status: :ok
  rescue => e
    Rails.logger.error("Error in InfrastructuresController#index: #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
    render json: { error: '取得できませんでした。' }, status: :internal_server_error
  end
end
