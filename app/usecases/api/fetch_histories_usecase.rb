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
        company_name: history.company_name,
        created_at: history.created_at,
        updated_at: history.updated_at
      )
    end

    Output.new(histories: histories)
  rescue => e
    Output.new(errors: e.message)
  end
end
