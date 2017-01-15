class Tweet < ActiveRecord::Base
    
validates :title, presence: true

end
