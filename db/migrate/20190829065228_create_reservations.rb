class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.date :meeting_on
      t.datetime :started_at
      t.datetime :finished_at
      t.string :telmail_name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
