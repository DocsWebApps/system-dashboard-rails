class ChangeIncidentsAddTime < ActiveRecord::Migration
  def change
    change_table :incidents do |t|
      t.change :date, :date
      t.time :time
    end
  end
end
