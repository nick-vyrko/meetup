class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.belongs_to :event, null: false, index: true
      t.belongs_to :user, null: false, index: true

      t.timestamps
    end
  end
end
