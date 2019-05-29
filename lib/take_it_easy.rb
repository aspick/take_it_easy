require "take_it_easy/version"
require 'active_support/lazy_load_hooks'

module TakeItEasy
  module ClassMethods
    def ignore_attributes=(names)
      @ignores = names
    end

    def ignore_attributes
      @ignores || []
    end
  end
  extend ClassMethods
end


ActiveSupport.on_load(:active_record) do
  require 'take_it_easy/model'
  require 'take_it_easy/node'

  ActiveRecord::Base.send(:include, TakeItEasy::Model)
end
