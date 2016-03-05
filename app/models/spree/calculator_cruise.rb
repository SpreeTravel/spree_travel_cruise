module Spree
  class CalculatorCruise < BaseCalculator

     def calculate_price(context, product, variant, options)
       return [price:product.price.to_f] if product.rates.empty?
      list = product.variants.where(id: variant.id).first.rates
      array = []
      list.each do |r|
         if Date.parse(r.start_date) <=  Date.parse(context.start_date(options).to_s) &&
              Date.parse(r.end_date) >=  Date.parse(context.start_date(options).to_s)
            double = r.send('double').to_f
            adult_count = context.adult(options).to_i
            price = adult_count/2 * double + adult_count%2 * double
            array << {price: price, rate: r.id, avg: double}
        end
      end
      array
    end


  end
end
