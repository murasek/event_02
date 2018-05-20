class Message < ActiveRecord::Base
  belongs_to :conversation　, presence: true
  belongs_to :user　, presence: true

  validates_presence_of :body, :conversation_id, :user_id
  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
