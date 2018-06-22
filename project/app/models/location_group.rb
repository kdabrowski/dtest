class LocationGroup < ApplicationRecord
  belongs_to :panel_provider
  belongs_to :country
  has_and_belongs_to_many :locations

  validates :name, presence: true
end
