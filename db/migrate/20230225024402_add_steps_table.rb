class AddStepsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :steps do |t|
      t.integer :position, null: false
      t.references :parent, null: true, foreign_key: { to_table: :steps }, index: true
      t.references :learnable, polymorphic: true, null: false
      t.references :path, null: false, foreign_key: true, index: true
      t.references :section, null: true, foreign_key: true, index: true

      t.timestamps
    end

    remove_column :courses, :path_id, :bigint
    remove_column :courses, :position, :integer

    remove_column :lessons, :course_id, :bigint
    remove_column :lessons, :section_id, :bigint
    remove_column :lessons, :position, :integer

  end
end
