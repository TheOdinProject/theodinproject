class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :mobile_number, :string
    add_column :users, :college, :string
    add_column :users, :degree, :string
    add_column :users, :graduation_year, :integer
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :operating_system, :string
    add_column :users, :resume, :string
  end
end
