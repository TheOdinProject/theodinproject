class CreateStepHierarchies < ActiveRecord::Migration[6.1]
  def change
    create_table :step_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end

    add_index :step_hierarchies, [:ancestor_id, :descendant_id, :generations],
      unique: true,
      name: "step_anc_desc_idx"

    add_index :step_hierarchies, [:descendant_id],
      name: "step_desc_idx"
  end
end
