class History < ApplicationRecord
  belongs_to :general
  belongs_to :position
  belongs_to :scale
  belongs_to :core_stack
  belongs_to :infrastructure
  belongs_to :user

  before_create :set_uuid

  private

  def set_uuid
    self.id = SecureRandom.uuid if id.blank?
  end
end
