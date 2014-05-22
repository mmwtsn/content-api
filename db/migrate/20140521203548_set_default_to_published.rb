class SetDefaultToPublished < ActiveRecord::Migration
  def up
    change_column_default :pages, :published, false
  end

  def down
    change_column_default :pages, :published, nil
  end
end
