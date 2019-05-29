module TakeItEasy
  class Node
    attr_accessor :class_name
    attr_accessor :attributes
    attr_accessor :value
    attr_accessor :associations

    def self.belongs_to_association_names(source_object)
      belongs_to_associations = source_object.class.reflect_on_all_associations(:belongs_to)
      belongs_to_associations.map{|a| a.name}
    end

    def self.fetch_attributes(source_object, value_name = nil)
      association_key_format = /([\w]+)_id/
      new_attributes = source_object.attributes.reject do |k,v|
          !!association_key_format.match(k)
      end
      new_attributes.reject! do |k,v|
          ['id', 'created_at', 'updated_at'].include?(k) || ::TakeItEasy.ignore_attributes.include?(k)
      end
      belongs_to_association_names(source_object).each do |name|
          new_attributes[name.to_s] = name.to_sym
      end

      tie = Node.new
      tie.class_name = source_object.class.name.downcase
      tie.attributes = new_attributes
      tie.value = value_name
      tie
    end

    def tie_attributes_string
      attributes.map do |k, v|
        value = case v
                when Symbol
                    "#{v.to_s}"
                else
                    v.to_json
                end

        value.gsub!(/\Anull\Z/,'nil')

        "#{k}: #{value}"
      end.join(', ')
    end

    def print(mode = :let)
      case mode
      when :raw, nil
        print_raw
      when :let
        print_let
      end
    end

    def print_raw
      buff = "".dup
      if @value
        buff += "#{@value} = "
      end

      buff += "create(:#{@class_name}, #{tie_attributes_string})"

      puts buff
    end

    def print_let
      puts "let(:#{@class_name}) { create(:#{@class_name}, #{tie_attributes_string}) }"
    end

  end
end
