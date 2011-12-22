#Module.delegate by active_support
class Module
# File activesupport/lib/active_support/core_ext/module/delegation.rb, line 106
  def delegate(*methods)
    options = methods.pop
    unless options.is_a?(Hash) && to = options[:to]
      raise ArgumentError, "Delegation needs a target. Supply an options hash with a :to key as the last argument (e.g. delegate :hello, :to => :greeter)."
    end

    if options[:prefix] == true && options[:to].to_s =~ /^[^a-z_]/
      raise ArgumentError, "Can only automatically set the delegation prefix when delegating to a method."
    end

    prefix = options[:prefix] && "#{options[:prefix] == true ? to : options[:prefix]}_" || ''

    file, line = caller.first.split(':', 2)
    line = line.to_i

    methods.each do |method|
      on_nil =
        if options[:allow_nil]
          'return'
        else
          %Q(raise "#{self}##{prefix}#{method} delegated to #{to}.#{method}, but #{to} is nil: \#{self.inspect}")
        end

      module_eval("        def #{prefix}#{method}(*args, &block)               # def customer_name(*args, &block)
          #{to}.__send__(#{method.inspect}, *args, &block)  #   client.__send__(:name, *args, &block)
        rescue NoMethodError                                # rescue NoMethodError
          if #{to}.nil?                                     #   if client.nil?
            #{on_nil}                                       #     return # depends on :allow_nil
          else                                              #   else
            raise                                           #     raise
          end                                               #   end
        end                                                 # end
", file, line - 1)
    end
  end
end

module ActiveSupport
  module Delegation #:nodoc:
    def self.perform(object, target, method, method_name, allow_nil, to, args, block)
      target.__send__(method, *args, &block)
    rescue NoMethodError
      if target.nil?
        return nil if allow_nil
        raise "#{object.class}##{method_name} delegated to #{to}.#{method}, but #{to} is nil: #{object.inspect}"
      else
        raise
      end
    end
  end
end
