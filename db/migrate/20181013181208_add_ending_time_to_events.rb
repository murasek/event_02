class AddEndingTimeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :ending_time, :datetime
  end
end
