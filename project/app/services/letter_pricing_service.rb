class LetterPricingService
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
    @price ||= a_occourance_count > 0 ? a_occourance_count.to_f/100 : nil
  end

  def a_occourance_count
    @page.at('body').text.scan(/a/i).count
  end
end

