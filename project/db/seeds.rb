PANEL_PROVIDERS_CODES = %w[times_a 10_arrays times_html].freeze

COUNTRIES = [
  { code: "PL", panel_provider_code: "times_a" },
  { code: "US", panel_provider_code: "10_arrays" },
  { code: "UK", panel_provider_code: "times_html" }
].freeze

LOCATIONS = [
  { name: "New York" },
  { name: "Los Angeles" },
  { name: "Chicago" },
  { name: "Houston" },
  { name: "Philadelphia" },
  { name: "Phoenix" },
  { name: "San Antonio" },
  { name: "San Diego" },
  { name: "Dallas" },
  { name: "San Jose" },
  { name: "Austin" },
  { name: "Jacksonville" },
  { name: "San Francisco" },
  { name: "Indianapolis" },
  { name: "Columbus" },
  { name: "Fort Worth" },
  { name: "Charlotte" },
  { name: "Detroit" },
  { name: "El Paso" },
  { name: "Seattle" }
].freeze

LOCATION_GROUPS = [
  { name: "Group 1" },
  { name: "Group 2" },
  { name: "Group 3" },
  { name: "Group 4" }
].freeze

ROOT_TARGET_GROUPS = [
  { name: "Root Group 1" },
  { name: "Root Group 2" },
  { name: "Root Group 3" },
  { name: "Root Group 4" }
].freeze

PANEL_PROVIDERS_CODES.each { |panel_provider_code| PanelProvider.create!(code: panel_provider_code) }

COUNTRIES.each do |country|
  Country.create!(
    code: country.fetch(:code),
    panel_provider: PanelProvider.find_by!(code: country.fetch(:panel_provider_code))
  )
end

LOCATIONS.each do |location|
  Location.create!(
    name: location.fetch(:name),
    external_id: SecureRandom.uuid,
    secret_code: SecureRandom.hex(64)
  )
end

LOCATION_GROUPS.each_with_index do |location_group, index|
  index  = (index >= 3 ? rand(2) : index)

  LocationGroup.create!(
    name: location_group.fetch(:name),
    country: Country.all.sample(1).first,
    panel_provider: PanelProvider.offset(index).first
  )
end

def create_children(parent)
  4.times do |n|
    n = (n >= 3 ? rand(2) : n)

    TargetGroup.create!(
      name: parent.name.gsub("Root", "Child"),
      external_id: SecureRandom.uuid,
      secret_code: SecureRandom.hex(64),
      parent: parent,
      panel_provider: PanelProvider.offset(n).first
    )
  end
end

ROOT_TARGET_GROUPS.each_with_index do |root_group, index|
  index  = (index >= 3 ? rand(2) : index)

  parent = TargetGroup.create!(
    name: root_group.fetch(:name),
    external_id: SecureRandom.uuid,
    secret_code: SecureRandom.hex(64),
    parent: nil,
    panel_provider: PanelProvider.offset(index).first
  )
  create_children(parent)
end

ActiveRecord::Base.transaction do
  TargetGroup.roots.flat_map(&:children).each { |parent| create_children(parent) }
  TargetGroup.roots.flat_map(&:children).flat_map(&:children).each { |parent| create_children(parent) }
end

