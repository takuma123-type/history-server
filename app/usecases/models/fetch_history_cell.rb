class Models::FetchHistoryCell
  include ActiveModel::Model

  attr_accessor :id, :period, :company_name, :project_name, :contents, :others,
                :position, :scale, :core_stack, :infrastructure
end
