class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.decimal :lat
      t.decimal :lng
      t.decimal :price

      t.timestamps
    end
  end
end
