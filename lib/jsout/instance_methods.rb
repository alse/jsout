module Jsout::InstanceMethods
  def jsout(template_name = :default, args = {})

    # Returns json if there are no presenters
    return self.to_json if Jsout.presenters.blank?

    @template_name    = template_name
    @resource_name    = get_resource_name
    @template         = Jsout.presenters[@resource_name][@template_name]
    @template_options = @template[:options]

    if self.kind_of?(Array) || self.kind_of?(ActiveRecord::Relation)
      result = []
      self.each { |object| result << parse_resource(object) }
    elsif self.kind_of?(ActiveRecord::Base)
      result = parse_resource(self)
    end

    result = {@template_options[:root].to_sym => result} if @template_options[:root]
    result.merge!(args[:include])                 if args[:include].present?

    case Jsout.output_format
    when :hash
      result
    else
      result.to_json
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