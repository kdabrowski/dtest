class Location < ApplicationRecord
  has_and_belongs_to_many :location_groups

  validates :name, presence: true
  validates :external_id, presence: true, uniqueness: true
  validates :secret_code, presence: true
end
