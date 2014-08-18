class AddNameToScenarios < ActiveRecord::Migration
  def change
    add_column :scenarios, :name, :string
  end
end
