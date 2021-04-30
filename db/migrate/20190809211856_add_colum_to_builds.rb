class AddColumToBuilds < ActiveRecord::Migration[5.2]
  def change
    add_column :builds, :image, :string
  end
end
