class AddVoteToContributions < ActiveRecord::Migration[5.2]
  def change
    add_column :contributions, :vote, :integer, default: 0
  end
end
