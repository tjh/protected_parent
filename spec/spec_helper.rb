# Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  
  begin
    require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
  rescue LoadError
    puts "You need to install rspec in your base app"
    exit
  end

  plugin_spec_dir = File.dirname(__FILE__)

  ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")
  databases = YAML::load(IO.read(plugin_spec_dir + "/db/database.yml"))
  ActiveRecord::Base.establish_connection(databases[ENV["DB"] || "sqlite3"])
  load(File.join(plugin_spec_dir, "db", "schema.rb"))
# end

# Spork.each_run do
  # This code will be run each time you run your specs.
  plugin_spec_dir = File.dirname(__FILE__)
  path = File.join(plugin_spec_dir, "models")
  $LOAD_PATH << File.join(plugin_spec_dir, "models")
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
# end