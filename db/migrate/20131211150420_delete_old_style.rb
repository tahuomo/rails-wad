class DeleteOldStyle < ActiveRecord::Migration
  def change
    remove_column :Beers, :old_style
  end
end
