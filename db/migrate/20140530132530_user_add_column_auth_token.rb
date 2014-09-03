class UserAddColumnAuthToken < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.string :auth_token
    end
  end
  
  def down
    change_table :users do |t|
      t.remove :auth_token
    end
  end
end
