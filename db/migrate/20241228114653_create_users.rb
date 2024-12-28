class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: false do |t|
      t.string :id, limit: 36, null: false, primary_key: true
      t.string :authentication_id, limit: 36, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_foreign_key :users, :authentications, column: :authentication_id
  end
end
