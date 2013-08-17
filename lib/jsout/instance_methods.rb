module Jsout::InstanceMethods
  def jsout(template_name = :default)
    return self.as_json if Jsout.presenters.blank?

    @template_name    = template_name
    @resource_name    = get_resource_name
    @template         = Jsout.presenters[@resource_name][@template_name]
    @template_options = @template[:options]

    if self.kind_of?(Array) || self.kind_of?(ActiveRecord::Relation)
      result = []
      self.each do |object|
        result << parse_resource(object)
      end
    elsif self.kind_of?(ActiveRecord::Base)
      result = parse_resource(self)
    end

    if @template_options[:include_root]
      {@resource_name => result}
    else
      result
    end
  end

  private
    def parse_resource(object)
      block = @template[:block] if @template.present?

      block.call object
    end

    def get_resource_name
      if self.kind_of?(Array) || self.kind_of?(ActiveRecord::Relation)
        self.first.class.to_s.downcase.to_sym
      elsif self.kind_of?(ActiveRecord::Base)
        self.class.to_s.downcase.to_sym
      end
    end
end