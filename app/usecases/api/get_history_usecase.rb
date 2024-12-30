class Api::GetHistoryUsecase < Api::Usecase
  class Input
    attr_accessor :user, :history_id

    def initialize(user:, history_id:)
      @user = user
      @history_id = history_id
    end
  end

  class Output
    attr_accessor :history, :errors

    def initialize(history: nil, errors: nil)
      @history = history
      @errors = errors
    end

    def success?
      @errors.nil?
    end
  end

  def get
    history = History.find_by(id: input.history_id, user: input.user)

    if history
      history_cell = Models::GetHistoryCell.new(
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
      Output.new(history: history_cell)
    else
      Output.new(errors: "History not found")
    end
  end
end
