class AddTotalToLineItems < ActiveRecord::Migration
  def change
    add_money :line_items, :total
  end
end
