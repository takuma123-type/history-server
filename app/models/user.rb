class User < ApplicationRecord
  belongs_to :authentication
  before_create :set_uuid

  private

  def set_uuid
    self.id = SecureRandom.uuid if id.blank?
  end
end
