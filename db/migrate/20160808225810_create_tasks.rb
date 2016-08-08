class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.boolean :done
      t.integer :list_id

      t.timestamps
    end
    add_index :tasks, :list_id
  end
end
