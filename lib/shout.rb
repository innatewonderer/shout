require "shout/version"
require 'shout/observable'
require 'shout/listener'
module Shout
  module_function
  def constantize(camel_cased_word)
    names = camel_cased_word.split('::')
    
    # Trigger a builtin NameError exception including the ill-formed constant in the message.
    Object.const_get(camel_cased_word) if names.empty?
    
    # Remove the first blank element in case of '::ClassName' notation.
    names.shift if names.size > 1 && names.first.empty?
    
    names.inject(Object) do |constant, name|
      if constant == Object
        constant.const_get(name)
      else
        candidate = constant.const_get(name)
      end
    end
  end
end
