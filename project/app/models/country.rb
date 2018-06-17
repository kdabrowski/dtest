class Country < ApplicationRecord
  belongs_to :panel_provider
  has_and_belongs_to_many :target_groups, -> { where(parent_id: nil) }

  validates :code, presence: true, uniqueness: true
  validates :panel_provider, presence: true
  has_many :location_groups
end
