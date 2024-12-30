class Models::FormattedHistoryCell
  include ActiveModel::Model

  attr_accessor :no, :period, :company_name, :project_name, :contents,
                :others, :position, :scale, :tech_stack, :infrastructure
end
