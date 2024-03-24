class AddTotalTicketsToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :total_tickets, :integer, null: false
  end
end
