class Api::FetchPositionsUsecase < Api::Usecase
  class Output < Api::Usecase::Output
    attr_accessor :positions

    def initialize(positions)
      @positions = positions
    end
  end

  def fetch
    positions = Position.order(created_at: :desc).map do |position|
      Models::PositionCell.new(
        id: position.id,
        name: position.name
      )
    end

    Output.new(positions)
  end
end
