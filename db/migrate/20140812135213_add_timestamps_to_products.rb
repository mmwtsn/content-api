class AddTimestampsToProducts < ActiveRecord::Migration
  def change
    add_timestamps :products
  end
end
