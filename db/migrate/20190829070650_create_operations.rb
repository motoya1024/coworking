class CreateOperations < ActiveRecord::Migration[5.1]
  def change
    create_table :operations do |t|
      t.integer :all_seat, :limit => 100
      t.integer :seat

      t.timestamps
    end
  end
end
