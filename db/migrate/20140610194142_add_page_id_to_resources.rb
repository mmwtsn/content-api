class AddPageIdToResources < ActiveRecord::Migration
  def change
    add_column :resources, :page_id, :integer
  end
end
