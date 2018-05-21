class CreateContributions < ActiveRecord::Migration[5.2]
  def change
    create_table :contributions do |t|
      t.references :user, foreign_key: true
      t.references :story, foreign_key: true
      t.string :color

      t.timestamps
    end
  end
end
