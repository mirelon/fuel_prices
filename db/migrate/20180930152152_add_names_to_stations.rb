class AddNamesToStations < ActiveRecord::Migration[5.2]
  def change
    add_column :stations, :name, :string
    add_column :stations, :brand, :string
    add_column :stations, :operator, :string
    add_column :stations, :opening_hours, :string
    add_column :stations, :toilets, :boolean
    add_column :stations, :shop, :boolean
  end
end
