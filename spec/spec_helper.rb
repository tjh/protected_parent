begin
  require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
rescue LoadError
  puts "You need to install rspec in your base app"
  exit
end

plugin_spec_dir = File.dirname(__FILE__)

# Load up the dummy db with the schema used by the dummy models
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")
databases = YAML::load(IO.read(plugin_spec_dir + "/db/database.yml"))
ActiveRecord::Base.establish_connection(databases[ENV["DB"] || "sqlite3"])
load(File.join(plugin_spec_dir, "db", "schema.rb"))

# Load the dummy models used in testing
path = File.join(plugin_spec_dir, "models")
$LOAD_PATH << File.join(plugin_spec_dir, "models")
ActiveSupport::Dependencies.load_paths << path
ActiveSupport::Dependencies.load_once_paths.delete(path)
