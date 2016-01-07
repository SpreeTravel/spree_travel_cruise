module Spree
  class CalculatorCruise < BaseCalculator

    def adults_range
      (1..3).to_a
    end

    def children_range
      (0..2).to_a
    end

    # TODO preparar esto para que reciba un rate y calcule el precio de un solo producto.....
    def calculate_price(context, product, variant, options)
      # TODO hacerlo generico para que se apte cuando hay cambios en los context por el usuario
      return [product.price.to_f] if product.rates.empty?
      # days = context.end_date(options).to_date - context.start_date(options).to_date rescue 1
      # rooms = context.rooms(options).to_i rescue 1
      # adults_hash = {1 => 'simple', 2 => 'double', 3 => 'triple'}
      list = product.variants.where(id: variant.id).first.rates
      array = []
      list.each do |r|
        puts r.inspect
        if Time.parse(r.start_date) <= Time.parse(context.start_date(options)) && Time.parse(r.end_date) >= Time.parse(context.end_date(options))
          double = r.send('double').to_f
          adult_count = context.adult(options).to_i
          price = adult_count/2 * double + adult_count%2 * double
          # price = price * days * rooms # TODO "x días por cuarto"
          array << {price: price, rate: r.id, avg: double}
        end
      end
      array

      # # list = list.where('start_date <= ?', context.start_date(options)) if context.start_date(options).present?
      # # list = list.where('end_date >= ?', context.end_date(options)) if context.end_date(options).present?
      # list = list.where(:adults => context.adult(options)) if context.adult(options).present?
      # list = list.where(:children => context.child(options)) if context.child(options).present?
      # list = list.where(:room => context.room(options)) if context.room(options).present?
      # list = list.where(:plan => context.plan(options)) if context.plan(options).present?
      # list = list.order('price ASC')
      # Log.debug(list.explain)
      # list
    end

    # TODO: el problma esta en que la variante es distinta para cada producto
    # y en el combo en el buscador salen los ID de los option types
    # y nunca matchea eso
    # def combination_string_for_generation(rate)
    #   plan = rate.plan
    #   raise Exception.new("SOMETHING WRONG") if rate.variant.option_values.count != 1
    #   room = rate.variant.option_values.first.id
    #   "ROOM:#{room},PLAN:#{plan}"
    # end
    
    def get_rate_price(rate, adults, children)
      adults = adults.to_i
      children = children.to_i
      adults_hash = {1 => 'simple', 2 => 'double', 3 => 'triple'}
      price = adults * rate.send(adults_hash[adults]).to_f
      price += rate.first_child.to_f if children >= 1
      price += rate.second_child.to_f if children == 2
      price
    end
  end
end
