class CreateBuilds < ActiveRecord::Migration[5.2]
  def change
    create_table :builds do |t|
      t.string :name
      t.string :description
      t.string :price
      t.integer :user_id
    end
  end
end
