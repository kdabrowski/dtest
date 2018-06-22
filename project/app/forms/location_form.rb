class LocationForm
  include ActiveModel::Model
  attr_accessor(
    :id,
    :panel_size
  )

  validates :id, presence: true
  validates :panel_size, presence: true
end
