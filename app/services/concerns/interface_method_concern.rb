# frozen_string_literal: true

module InterfaceMethodConcern
  extend ActiveSupport::Concern

  class_methods do
    def define_interface_method(method_names)
      Array.wrap(method_names).map do |method_name|
        raise "#{method_name} already defined" if method_defined?(method_name)

        define_method(method_name) do |*_args|
          raise NotImplementedError, "#{self.class} needs to implement '#{method_name}'!"
        end

        yield(method_name) if block_given?
      end
    end

    def define_private_interface_method(method_names)
      define_interface_method(method_names) do |method_name|
        send(:private, method_name)
      end
    end
  end
end
