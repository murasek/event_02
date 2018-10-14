class AddOpeningTimeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :opening_time, :datetime
  end
end
