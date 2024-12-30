class Api::FetchCoreStacksUsecase < Api::Usecase
  class Input < Api::Usecase::Input
    # 必要に応じて入力パラメータを定義
  end

  class Output < Api::Usecase::Output
    attr_accessor :corestacks

    def initialize(corestacks)
      @corestacks = corestacks
    end
  end

  def fetch
    corestacks = CoreStack.order(created_at: :desc).map do |corestack|
      Models::CoreStackCell.new(
        id: corestack.id,
        name: corestack.name
      )
    end

    Output.new(corestacks)
  end
end
