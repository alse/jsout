require "jsout"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", 
                                        :database => File.dirname(__FILE__) + "/jsout.sqlite3")

load File.dirname(__FILE__) + "/support/schema.rb"
load File.dirname(__FILE__) + "/support/models.rb"
load File.dirname(__FILE__) + "/support/data.rb"
load File.dirname(__FILE__) + "/support/config_jsout.rb"
