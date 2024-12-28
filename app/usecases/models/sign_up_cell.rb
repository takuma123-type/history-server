class Models::SignUpCell
  include ActiveModel::Model

  attr_accessor :email, :password, :name, :token
end
