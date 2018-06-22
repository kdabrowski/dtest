class NodePricingService
  require 'open-uri'
  attr_reader :page

  def initialize
  end

  def call
    parse_page
    calculate_price
    @price
  end

  private

  attr_writer :price

  def parse_page
    @page ||= Nokogiri::HTML(open("http://time.com/"))
  end

  def calculate_price
    res = []
    @page.traverse { |e| res << e }
    @price ||= (res.count.to_f / 100)
  end
end
