class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
