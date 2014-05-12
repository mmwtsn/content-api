class ChangeBodyToText < ActiveRecord::Migration
  def self.up
    change_column :pages, :body, :text
  end

  def self.down
    change_column :pages, :body, :string
  end
end
