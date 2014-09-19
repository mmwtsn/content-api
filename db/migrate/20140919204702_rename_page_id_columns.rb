class RenamePageIdColumns < ActiveRecord::Migration
  def change
    rename_column :scenarios, :page_id, :solution_id
    rename_column :resources, :page_id, :solution_id
  end
end
