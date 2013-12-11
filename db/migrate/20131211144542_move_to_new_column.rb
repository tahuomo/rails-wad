class MoveToNewColumn < ActiveRecord::Migration
  def change
    rename_column :Beers, :style, :old_style
  end
end
