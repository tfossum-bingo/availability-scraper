class CreateAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :availabilities do |t|
      t.references :listing, null: false, foreign_key: true
      t.date :availability_date
      t.boolean :available

      t.timestamps
    end
  end
end
