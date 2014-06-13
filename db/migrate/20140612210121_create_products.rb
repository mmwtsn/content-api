class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :scenario, index: true
      t.integer :product_id
    end
  end
end
