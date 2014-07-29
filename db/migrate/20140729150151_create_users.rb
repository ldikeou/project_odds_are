class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :lstatus
      t.string :profpic
      t.string :about

      t.timestamps
    end
  end
end
