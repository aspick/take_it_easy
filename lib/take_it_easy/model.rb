require 'take_it_easy/model'
require 'active_record/base'

module TakeItEasy
  module Model
    def take_it_easy
      tie_objects ||= []
      tie_objects << TakeItEasy::Node.fetch_attributes(self)
      tie_target_objects.each do |obj|
        tie_objects << TakeItEasy::Node.fetch_attributes(obj, obj.class.name.downcase)
      end
      tie_objects.reverse.each do |tie_object|
        tie_object.print
      end
    end

    private

    def tie_target_objects
      @@root_tie_objects = []
      tie_target_objects_inner(self)
      @@root_tie_objects.uniq
    end

    def tie_target_objects_inner(target)
      assoc_names = TakeItEasy::Node.belongs_to_association_names(target)
      objs = assoc_names.map{|name|
        target.send(name.to_sym)
      }.select{|obj|
        !!obj
      }
      @@root_tie_objects.append(*objs)
      objs.each{|obj|
        tie_target_objects_inner(obj)
      }
    end
  end
end
