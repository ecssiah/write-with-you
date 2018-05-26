class AddDarkThemeToStories < ActiveRecord::Migration[5.2]
  def change
    add_column :stories, :dark_theme, :boolean
  end
end
