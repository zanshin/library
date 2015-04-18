require 'sinatra'
require 'sinatra/static_assets'
require 'data_mapper'

# database setup
# DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/library.db")
# DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/library.db")
DataMapper.setup(:default, "sqlite3://#{File.dirname(File.expand_path(__FILE__))}/library.db")

configure do
  set :views, ['views/layouts', 'views/pages', 'views/partials']
  #enable :sessions
end

Dir["./app/models/*.rb"].each { |file| require file }
Dir["./app/helpers/*.rb"].each { |file| require file }
Dir["./app/controllers/*.rb"].each { |file| require file }

before "/*" do 
  if mobile_request?
    set :erb, :layout => :mobile
  else
    set :erb, :layout => :layout
  end
end

DataMapper.auto_upgrade!
