class AddTimestampsToScenarios < ActiveRecord::Migration
  def change
    add_timestamps :scenarios
  end
end
