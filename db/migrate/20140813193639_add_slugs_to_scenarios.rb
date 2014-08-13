class AddSlugsToScenarios < ActiveRecord::Migration
  def change
    add_column :scenarios, :slug, :string
    add_index :scenarios, :slug
  end
end
