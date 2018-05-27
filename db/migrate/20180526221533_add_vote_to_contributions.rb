class AddVoteToContributions < ActiveRecord::Migration[5.2]
  def change
    add_column :contributions, :vote, :integer
  end
end
