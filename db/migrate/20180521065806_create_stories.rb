class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :title
      t.integer :snippet_length, default: 255
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
