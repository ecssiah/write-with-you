class CreateSnippets < ActiveRecord::Migration[5.2]
  def change
    create_table :snippets do |t|
      t.references :story, foreign_key: true

      t.string :content
      t.boolean :paragraph_begin
      t.boolean :paragraph_end

      t.timestamps
    end
  end
end
