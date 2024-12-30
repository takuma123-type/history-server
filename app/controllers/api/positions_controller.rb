class Api::PositionsController < Api::BaseController
  skip_before_action :verify_authenticity_token

  def index
    usecase = Api::FetchPositionsUsecase.new(
      input: Api::FetchPositionsUsecase::Input.new
    )
    @output = usecase.fetch

    render json: @output.positions, status: :ok
  rescue => e
    Rails.logger.error("エラー Fetchに失敗しました。: #{e.message}")
    Rails.logger.error(e.backtrace.join("\n"))
    render json: { error: '取得できませんでした。' }, status: :internal_server_error
  end
end
