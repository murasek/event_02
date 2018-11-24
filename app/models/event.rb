class Event < ActiveRecord::Base
validates :title, presence: true
validates :content, presence: true
validates :opening_time, presence: true
validates :ending_time, presence: true
belongs_to :user
belongs_to :owner,class_name:'User'
def created_by?(user)
   return false unless user
   owner_id == user.id
end

# CommentモデルのAssociationを設定
  # has_many :comments, dependent: :destroy
  has_many :tickets,dependent: :destroy



mount_uploader :image, ImageUploader

def self.future
    # イベントを、開始時間の昇順で並べ替え。開始時間が現在時間より後のイベントのみ取得。
    order(:opening_time).select { |event| event if Time.zone.now < event.opening_time }
  end
end
