class EvaluateTargetForm
  include ActiveModel::Model
  attr_accessor(
    :country_code,
    :target_group_id,
    :locations
  )

  validates :country_code, presence: true
  validates :target_group_id, presence: true
  validates :locations, presence: true

  def valid?
    super && locations_valid?
  end

  def price
    find_country
    case @country.panel_provider_code
    when "times_a"
      LetterPricingService.new.call
    when "10_arrays"
      ArrayPricingService.new.call
    when "times_html"
      NodePricingService.new.call
    end
  end

  private

  def find_country
    @country = Country.find_by!(code: country_code)
  end

  def locations_valid?
    return unless locations
    locations.map { |l| LocationForm.new(id: l["id"], panel_size: l["panel_size"]) }
      .map(&:valid?).all? { |e| e == true }
  end

end
