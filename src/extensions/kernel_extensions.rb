module Kernel
  def subclass_with_equals(class_symbol)
    clazz = Kernel.const_get(class_symbol.to_s)
    Kernel.subclass_with_default_equals(clazz)
  end

  private

  def self.subclass_with_default_equals(base_class)
    sub_class = Class.new(base_class)
    sub_class.class_eval do
      def ==(other)
        instance_variables.all? { |v| self.instance_variable_get(v) == other.instance_variable_get(v) } and other.instance_of? self.class
      end
    end
    sub_class
  end
end