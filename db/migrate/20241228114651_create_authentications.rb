class CreateAuthentications < ActiveRecord::Migration[8.0]
  def change
    create_table :authentications, id: false do |t|
      t.string :id, limit: 36, null: false, primary_key: true
      t.string :login_id, null: false
      t.string :password_digest, null: false

      t.timestamps
    end
  end
end
