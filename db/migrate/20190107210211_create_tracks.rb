class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.string :title
      t.text :description
      t.references :track_unit

      t.timestamps
    end
  end
end
