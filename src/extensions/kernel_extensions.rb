module Kernel
  def add_equals_method(*class_symbols)
    clazzes = class_symbols.map { |symbol| Kernel.const_get(symbol.to_s) }
    clazzes.each { |clazz| add_equals clazz }
    if (block_given?)
      yield
      clazzes.each { |clazz| remove_equals clazz }
    end
  end

  private

  def add_equals(clazz)
    clazz.class_eval do
      alias :__old_equals2917 :==
      def ==(other)
        instance_variables.all? { |v| self.instance_variable_get(v) == other.instance_variable_get(v) } and other.instance_of? self.class
      end
    end
  end

  def remove_equals(clazz)
    clazz.class_eval do
      remove_method :==
      alias :== :__old_equals2917
      remove_method :__old_equals2917
    end
  end
end