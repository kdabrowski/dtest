class NodePricingService
  require 'open-uri'

  attr_reader :page

  def call
    parse_page
    calculate_price
    @price
  end

  private

  attr_writer :price

  def parse_page
    @page ||= Nokogiri::HTML(open(Settings.time_url))
  end

  def calculate_price
    res = []
    @page.traverse { |e| res << e }
    @price ||= res.count > 0 ? (res.count.to_f) / 100 : nil
  end
end
