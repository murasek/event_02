class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :user
      t.references :event, null:false
      t.string :comment
      t.timestamps
    end







  end
end
