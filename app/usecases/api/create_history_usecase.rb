class Api::CreateHistoryUsecase < Api::Usecase
  class Input < Api::Usecase::Input
    attr_accessor :user, :params

    def initialize(user:, params:)
      @user = user
      @params = params
    end
  end

  class Output < Api::Usecase::Output
    attr_accessor :history, :errors

    def initialize(history: nil, errors: nil)
      @history = history
      @errors = errors
    end

    def success?
      @errors.nil?
    end
  end

  def create
    ActiveRecord::Base.transaction do
      # 関連データを作成または取得
      position = Position.find_or_create_by(id: input.params[:position][:id]) do |pos|
        pos.name = input.params[:position][:name]
      end
  
      scale = Scale.find_or_create_by(id: input.params[:scale][:id]) do |s|
        s.people = input.params[:scale][:people]
      end
  
      core_stack = CoreStack.find_or_create_by(id: input.params[:core_stack][:id]) do |cs|
        cs.name = input.params[:core_stack][:name]
      end
  
      infrastructure = Infrastructure.find_or_create_by(id: input.params[:infrastructure][:id]) do |i|
        i.name = input.params[:infrastructure][:name]
      end
  
      # Generalを取得または作成
      general = input.user.general || General.create!(user: input.user)
  
      # Historyを作成
      history = History.new(
        user: input.user,
        general: general, # Generalを関連付け
        position: position,
        scale: scale,
        core_stack: core_stack,
        infrastructure: infrastructure,
        period: input.params[:period],
        company_name: input.params[:company_name],
        project_name: input.params[:project_name],
        contents: input.params[:contents],
        others: input.params[:others]
      )
  
      if history.save
        return Output.new(history: history)
      else
        return Output.new(errors: history.errors.full_messages)
      end
    end
  rescue => e
    Output.new(errors: e.message)
  end  
end
