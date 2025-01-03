class ChangePeriodToBeStringInHistories < ActiveRecord::Migration[8.0]
  def up
    change_column :histories, :period, :string
  end

  def down
    change_column :histories, :period, :datetime
  end
end
