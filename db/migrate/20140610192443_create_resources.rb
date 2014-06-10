class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :body
      t.string :url
    end
  end
end
