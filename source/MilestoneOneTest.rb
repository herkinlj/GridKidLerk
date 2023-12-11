require_relative './CellValue.rb'
require_relative './Environment.rb'
require_relative './Grid.rb'
require_relative './Operation.rb'
require_relative './Primitive'
module MilestoneOneTest
  var1 = IntegerPrimitive.new(5)
  var2 = IntegerPrimitive.new(10)
  var3 = Divide.new(var1, var2)
  puts var3.operand_one
  puts var3.operand_two

  puts "#{var3.evaluate(0).value}"
end
