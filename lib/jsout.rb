require "jsout/version"

require "active_support/core_ext"
require "active_support"
require "active_record"

require "jsout/instance_methods"

module Jsout
  mattr_accessor :presenters
  self.presenters ||= {}

  def self.present(resource_name, &block)
    resource_name = resource_name.to_s.downcase.to_sym

    template = Template.new(resource_name)
    template.instance_eval(&block) if block_given?
  end

  class Template
    def initialize(resource_name)
      @resource_name = resource_name
    end

    def template(template_name = :default, options = {}, &block)
      Jsout.presenters[@resource_name] ||= {}
      Jsout.presenters[@resource_name].merge!({template_name => {block: block, options: options}})
    end
  end
end

if defined? ActiveRecord::Base
  ActiveRecord::Base.send :include, Jsout::InstanceMethods
  Array.send :include, Jsout::InstanceMethods
end
