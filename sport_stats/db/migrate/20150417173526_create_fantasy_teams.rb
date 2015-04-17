class CreateFantasyTeams < ActiveRecord::Migration
  def change
    create_table :fantasy_teams do |t|
      t.string :name
      t.string :player
      t.string :sport
      t.references :user

      t.timestamps null: false
    end
  end
end
