class AddTimestampsToResources < ActiveRecord::Migration
  def change
    add_timestamps :resources
  end
end
