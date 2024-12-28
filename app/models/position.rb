class Position < ApplicationRecord
  has_many :histories
  before_create :set_uuid

  private

  def set_uuid
    self.id = SecureRandom.uuid if id.blank?
  end
end
