class Api::FetchHistoriesUsecase < Api::Usecase
  class Input
    attr_accessor :user

    def initialize(user:)
      @user = user
    end
  end

  class Output
    attr_accessor :histories, :errors

    def initialize(histories: nil, errors: nil)
      @histories = histories
      @errors = errors
    end

    def success?
      @errors.nil?
    end
  end

  def fetch
    histories = History.where(user: input.user).order(created_at: :desc).map do |history|
      Models::FetchHistoryCell.new(
        id: history.id,
        period: history.period,
        company_name: history.company_name,
        project_name: history.project_name,
        contents: history.contents,
        others: history.others,
        position: {
          id: history.position.id,
          name: history.position.name
        },
        scale: {
          id: history.scale.id,
          people: history.scale.people
        },
        core_stack: {
          id: history.core_stack.id,
          name: history.core_stack.name
        },
        infrastructure: {
          id: history.infrastructure.id,
          name: history.infrastructure.name
        }
      )
    end

    Output.new(histories: histories)
  rescue => e
    Output.new(errors: e.message)
  end
end
