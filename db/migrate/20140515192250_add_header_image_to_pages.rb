class AddHeaderImageToPages < ActiveRecord::Migration
  def self.up
    add_attachment :pages, :header
  end

  def self.down
    remove_attachment :pages, :header
  end
end
