class AddCreatorToStories < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :creator_id, :integer
  end
end
