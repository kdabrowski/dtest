class TargetGroup < ApplicationRecord
  validates :code, presence: true, uniqueness: true
end
