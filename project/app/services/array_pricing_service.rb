class ArrayPricingService
  include HTTParty
  attr_accessor :result

  def call
    @result = get_result
    calculate_price
    @price
  end

  private

  def get_result
    @result ||= JSON.parse(self.class.get(Settings.lib_query_url))
  end

  def calculate_price
    @price ||= @result["docs"].select { |e| e.is_a?(Hash) }.reduce(0) do |n, element|
      n + count_arrays_bigger_than_10(element)
    end
  end

  def count_arrays_bigger_than_10(element)
    element.values.compact.select { |e| e.is_a?(Array) && e.count > 10 }.count
  end
end
