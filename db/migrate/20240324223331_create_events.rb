class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.belongs_to :user, null: false, index: true

      t.string :name, null: false
      t.datetime :datetime, null: false
      t.text :description
      t.decimal :latitude, null: false
      t.decimal :longitude, null: false

      t.timestamps
    end
  end
end
