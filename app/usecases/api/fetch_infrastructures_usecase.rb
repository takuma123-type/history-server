class Api::FetchInfrastructuresUsecase < Api::Usecase
  class Output < Api::Usecase::Output
    attr_accessor :infrastructures

    def initialize(infrastructures)
      @infrastructures = infrastructures
    end
  end

  def fetch
    infrastructures = Infrastructure.order(created_at: :desc).map do |infrastructure|
      Models::InfrastructureCell.new(
        id: infrastructure.id,
        name: infrastructure.name
      )
    end
  
    Output.new(infrastructures)
  end
  
end
