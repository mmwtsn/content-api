class AddAvatarColumnToScenarios < ActiveRecord::Migration
  def up
    add_attachment :scenarios, :avatar
  end

  def down
    remove_attachment :scenarios, :avatar
  end
end
