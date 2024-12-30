class Api::FetchScalesUsecase < Api::Usecase
  class Output < Api::Usecase::Output
    attr_accessor :scales

    def initialize(scales)
      @scales = scales
    end
  end

  def fetch
    scales = Scale.order(created_at: :desc).map do |scale|
      Models::ScaleCell.new(
        id: scale.id,
        people: scale.people
      )
    end

    Output.new(scales)
  end
end
