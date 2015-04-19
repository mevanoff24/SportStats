class CreateFantasyTeamsPlayers < ActiveRecord::Migration
  def change
    create_table :fantasy_teams_players do |t|
    	t.references :fantasy_team
    	t.references :player

      t.timestamps null: false
    end
  end
end
