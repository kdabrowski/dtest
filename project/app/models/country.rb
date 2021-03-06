class Country < ApplicationRecord
  belongs_to :panel_provider
  has_many :location_groups
  has_many :locations, through: :location_groups
  has_and_belongs_to_many :target_groups, -> { where(parent_id: nil) }

  validates :code, presence: true, uniqueness: true
  validates :panel_provider, presence: true

  delegate :code, to: :panel_provider, prefix: true
end
