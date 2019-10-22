class CreateOperations < ActiveRecord::Migration[5.1]
  def change
    create_table :operations do |t|
      t.integer :all_seat, :limit => 1000
      t.integer :seat

      t.timestamps
    end
  end
end
