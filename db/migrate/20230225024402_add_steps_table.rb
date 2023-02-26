class AddStepsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :steps do |t|
      t.integer :position, null: false, index: true
      t.references :parent, null: true, foreign_key: { to_table: :steps }, index: true
      t.references :learnable, polymorphic: true, null: false
      t.references :path, null: false, foreign_key: true

      t.timestamps
    end

    add_index :steps, %i[learnable_type learnable_id path_id], unique: true

    remove_column :courses, :path_id, :bigint
    remove_column :courses, :position, :integer

    remove_column :sections, :course_id, :bigint
    remove_column :sections, :position, :integer

    remove_column :lessons, :course_id, :bigint
    remove_column :lessons, :section_id, :bigint
    remove_column :lessons, :position, :integer
  end
end
