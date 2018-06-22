class TargetGroup < ApplicationRecord
  belongs_to :panel_provider
  belongs_to :parent, class_name: "TargetGroup", optional: true
  has_many :children, class_name: "TargetGroup", foreign_key: :parent_id

  validates :secret_code, presence: true, uniqueness: true
end
