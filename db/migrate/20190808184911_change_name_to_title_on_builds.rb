class ChangeNameToTitleOnBuilds < ActiveRecord::Migration[5.2]
  def change
    rename_column :builds, :name, :title
  end
end
