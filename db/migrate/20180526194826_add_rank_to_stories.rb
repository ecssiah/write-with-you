class AddRankToStories < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :rank, :float, default: 0
  end
end
