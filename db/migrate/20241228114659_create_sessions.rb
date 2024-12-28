class CreateSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :sessions, id: false do |t|
      t.string :id, limit: 36, null: false, primary_key: true
      t.string :authentication_id, limit: 36, null: false
      t.string :token, null: false

      t.timestamps
    end

    add_foreign_key :sessions, :authentications, column: :authentication_id
  end
end
