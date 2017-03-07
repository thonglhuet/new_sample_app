class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.validates.micropost_content.max_length}
  validate :picture_size

  scope :my_scope, ->{order created_at: :desc}
  mount_uploader :picture, PictureUploader

  private

  def picture_size
    if picture.size > Settings.validates.picture_size.size.megabytes
      errors.add :picture, Settings.validates.micropost_error
    end
  end
end
