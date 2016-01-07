# Clase para probar un punto, no debe quedarse, si el cambio hace falta en el core dustet 30/12/2014
module Spree
  Product.class_eval do

    def cruise?
      self.product_type == Spree::ProductType.find_by_name('cruise')
    end

  end
end
