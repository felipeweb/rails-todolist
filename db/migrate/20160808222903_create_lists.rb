class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :name
      t.boolean :public
      t.integer :user_id

      t.timestamps
    end
    add_index :lists, :user_id
  end
end
