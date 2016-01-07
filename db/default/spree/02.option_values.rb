### These are the option types
cabin_type = Spree::OptionType.find_by_name!("cabin_type")

### This is the data
option_values = [
  {:name => "inside-cabin", :presentation => "Inside Cabin", :option_type => cabin_type},
  {:name => "outside-cabin", :presentation => "Outside Cabin", :option_type => cabin_type},
  {:name => "balcony-cabin", :presentation => "Balcony Cabin", :option_type => cabin_type},
  {:name => "suite-cabin", :presentation => "Suite Cabin", :option_type => cabin_type},
 
]

### Creating Option Values
option_values.each do |ov|
  Spree::OptionValue.create(ov)
end
