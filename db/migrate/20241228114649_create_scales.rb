class CreateScales < ActiveRecord::Migration[8.0]
  def change
    create_table :scales, id: false do |t|
      t.string :id, limit: 36, null: false, primary_key: true
      t.string :people, null: false

      t.timestamps
    end
  end
end
