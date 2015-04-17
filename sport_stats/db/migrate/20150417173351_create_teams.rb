class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :sport, default: "MLB"
      t.string :stadium
      t.string :city
      t.string :image
      t.string :division
      t.references :user

      t.timestamps null: false
    end
  end
end
