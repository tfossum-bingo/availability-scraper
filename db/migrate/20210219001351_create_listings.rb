class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.references :host, null: false, foreign_key: true
      t.integer :airbnb_id
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :postal_code
      t.boolean :active
      t.datetime :last_scraped

      t.timestamps
    end
  end
end
