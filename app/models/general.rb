class General < ApplicationRecord
  belongs_to :user
  before_create :set_uuid

  private

  def set_uuid
    self.id = SecureRandom.uuid if id.blank?
  end
end
