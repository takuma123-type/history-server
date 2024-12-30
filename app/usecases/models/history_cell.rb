class Models::HistoryCell
  include ActiveModel::Model

  attr_accessor :id, :period, :company_name, :project_name, :contents, :others,
                :position, :scale, :core_stack, :infrastructure

  def initialize(history)
    @id = history.id
    @period = history.period
    @company_name = history.company_name
    @project_name = history.project_name
    @contents = history.contents
    @others = history.others
    @position = { id: history.position.id, name: history.position.name }
    @scale = { id: history.scale.id, people: history.scale.people }
    @core_stack = { id: history.core_stack.id, name: history.core_stack.name }
    @infrastructure = { id: history.infrastructure.id, name: history.infrastructure.name }
  end
end
