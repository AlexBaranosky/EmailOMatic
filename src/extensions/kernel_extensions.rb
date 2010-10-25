module Kernel
  def add_equals_method(*class_symbols)
    class_symbols.each do |symbol|
      clazz = Kernel.const_get(symbol.to_s)
      clazz.class_eval do
        def ==(other)
          instance_variables.all? { |v| self.instance_variable_get(v) == other.instance_variable_get(v) } and other.instance_of? self.class
        end
      end
    end
  end
end