class CreateSnippets < ActiveRecord::Migration[5.2]
  def change
    create_table :snippets do |t|
      t.string :content
      t.references :story, foreign_key: true

      t.timestamps
    end
  end
end
