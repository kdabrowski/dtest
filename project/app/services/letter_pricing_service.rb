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
    @page ||= Nokogiri::HTML(open("http://time.com/"))
  end

  def calculate_price
    @price ||= @page.at('body').text.scan(/a/i).count.to_f/100
  end
end

