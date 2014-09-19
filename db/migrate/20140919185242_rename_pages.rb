class RenamePages < ActiveRecord::Migration
  def change
    rename_table :pages, :solutions
  end
end
