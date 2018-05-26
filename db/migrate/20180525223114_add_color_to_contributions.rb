class AddColorToContributions < ActiveRecord::Migration[5.2]
  def change
    add_column :contributions, :color, :string
  end
end
