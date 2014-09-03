class ChangeSystemsStatus < ActiveRecord::Migration
  def change
  	change_column :systems, :status, :string
  end
end
