class CreateGenerals < ActiveRecord::Migration[8.0]
  def change
    create_table :generals, id: false do |t|
      t.string :id, limit: 36, null: false, primary_key: true
      t.string :user_id, limit: 36, null: false

      t.timestamps
    end

    add_foreign_key :generals, :users, column: :user_id
  end
end
