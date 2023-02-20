class DynamicClass
  def initialize(name)
    @name = Object.const_set(name.capitalize, Class.new)
  end
  def def_method(method_name, method_body)
    @name.class_eval do
      define_method(method_name) do
        eval method_body
      end
    end

    p "Hello, your class #{@name} with method #{method_name} is ready, Calling: #{@name}.new.#{method_name}: "
    p call(method_name)
  end
  def call(methodname)
    @name.new.instance_eval do
      send(methodname)
    end
  rescue=>e
    e
  end
end

puts("Please enter the class name: ")
class_name = gets.chomp
puts("Please enter the method name you wish to define: ")
method_name = gets.chomp
puts("Please enter the method code")
method_body = gets.chomp
my_class = DynamicClass.new(class_name)
my_class.def_method(method_name, method_body)
