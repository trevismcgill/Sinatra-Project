class CreateBoardGames < ActiveRecord::Migration
  def change
    create_table :board_games do |t|
      t.string :title
      t.string :num_of_players
      t.integer :user_id
    

      t.timestamps null: false
    end
  end
end
