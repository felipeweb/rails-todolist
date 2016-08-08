class CreateFavoriteList < ActiveRecord::Migration[5.0]
  def change
    create_table :favorite_lists do |t|
      t.integer :user_id
      t.integer :list_id

      t.timestamps null: false
    end
    add_index :favorite_lists, :list_id
    add_index :favorite_lists, :user_id
  end
end
