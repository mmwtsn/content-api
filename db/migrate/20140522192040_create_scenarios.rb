class CreateScenarios < ActiveRecord::Migration
  def change
    create_table :scenarios do |t|
      t.references :page, index: true
      t.text :quote
      t.text :pitch
    end
  end
end
