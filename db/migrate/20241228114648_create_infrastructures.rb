class CreateInfrastructures < ActiveRecord::Migration[8.0]
  def change
    create_table :infrastructures, id: false do |t|
      t.string :id, limit: 36, null: false, primary_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
