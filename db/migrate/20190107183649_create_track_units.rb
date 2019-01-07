class CreateTrackUnits < ActiveRecord::Migration[5.0]
  def change
    create_table :track_units do |t|
      t.string :name
      t.references :lesson

      t.timestamps
    end
  end
end
