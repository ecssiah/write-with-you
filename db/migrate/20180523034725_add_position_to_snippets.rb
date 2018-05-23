class AddPositionToSnippets < ActiveRecord::Migration[5.2]
  def change
    add_column :snippets, :position, :integer
  end
end
