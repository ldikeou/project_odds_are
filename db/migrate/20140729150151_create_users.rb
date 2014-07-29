class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :l_status
      t.text :about

      t.timestamps
    end
  end
end
