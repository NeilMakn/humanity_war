class FixChuckTypo < ActiveRecord::Migration
  def change
    rename_column :entries, :loses, :losses
  end
end
