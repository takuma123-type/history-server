class CreateHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :histories, id: false do |t|
      t.string :id, limit: 36, null: false, primary_key: true
      t.string :general_id, limit: 36, null: false
      t.string :position_id, limit: 36, null: false
      t.string :scale_id, limit: 36, null: false
      t.string :core_stack_id, limit: 36, null: false
      t.string :infrastructure_id, limit: 36, null: false
      t.datetime :period
      t.string :company_name, null: false
      t.string :project_name
      t.string :contents
      t.string :others

      t.timestamps
    end

    add_foreign_key :histories, :generals, column: :general_id
    add_foreign_key :histories, :positions, column: :position_id
    add_foreign_key :histories, :scales, column: :scale_id
    add_foreign_key :histories, :core_stacks, column: :core_stack_id
    add_foreign_key :histories, :infrastructures, column: :infrastructure_id
  end
end
