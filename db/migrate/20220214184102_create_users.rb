class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :password, limit: 16, null: false

      t.timestamps
    end
  end
end
