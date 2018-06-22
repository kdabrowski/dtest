class PanelProvider < ApplicationRecord
  has_many :countries

  validates :code, presence: true, uniqueness: true
end
