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
  end
end
