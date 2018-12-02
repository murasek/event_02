class Event < ActiveRecord::Base
validates :title, presence: true
validates :content, presence: true
validates :opening_time, presence: true
validates :ending_time, presence: true
belongs_to :user
belongs_to :owner,class_name:'User'

validate :opening_time_should_be_before_ending_time
validate :opening_time_should_be_after_current_time
has_many :tickets,dependent: :destroy
def created_by?(user)
   return false unless user
   owner_id == user.id
end

# CommentモデルのAssociationを設定
  # has_many :comments, dependent: :destroy




mount_uploader :image, ImageUploader

def self.future
      # イベントを、開始時間の昇順で並べ替え。開始時間が現在時間より後のイベントのみ取得。
    order(:opening_time).select { |event| event if Time.zone.now < event.opening_time }
  end
end

private
def opening_time_should_be_before_ending_time
   return unless opening_time && ending_time

   if opening_time >= ending_time
     errors.add(:opening_time, 'は終了時間よりも前に設定してください')
   end

 end

def opening_time_should_be_after_current_time

 if t = Time.now and t >= opening_time
 errors.add(:opening_time, 'は現在時刻よりも前に設定してください')
 end

 end
