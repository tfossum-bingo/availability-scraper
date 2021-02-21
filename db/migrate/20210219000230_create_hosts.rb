class CreateHosts < ActiveRecord::Migration[6.0]
  def change
    create_table :hosts do |t|
      t.string :host_name
      t.integer :airbnb_id
      t.boolean :active
      t.datetime :last_scrapped

      t.timestamps
    end
  end
end
