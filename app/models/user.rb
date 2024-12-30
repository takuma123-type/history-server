class User < ApplicationRecord
  belongs_to :authentication
  has_one :general, dependent: :destroy

  before_create :set_uuid
  after_create :create_general

  private

  def set_uuid
    self.id = SecureRandom.uuid if id.blank?
  end

  def create_general
    General.create!(user: self)
  rescue => e
    Rails.logger.error("General creation failed for User ID #{self.id}: #{e.message}")
  end
end
