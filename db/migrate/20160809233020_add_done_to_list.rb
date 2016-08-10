class AddDoneToList < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :done, :boolean
  end
end
