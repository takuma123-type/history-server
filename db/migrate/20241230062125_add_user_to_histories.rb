class AddUserToHistories < ActiveRecord::Migration[8.0]
  def change
    add_column :histories, :user_id, :string, limit: 36, null: false
    add_foreign_key :histories, :users, column: :user_id
  end
end
