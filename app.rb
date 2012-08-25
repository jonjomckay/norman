require 'sinatra/base'
require 'sinatra/reloader'

class Norman < Sinatra::Base
  Rabl.register!

  app = Dragonfly[:images].configure_with(:imagemagick) do |c|
    c.datastore = Dragonfly::DataStorage::MongoDataStore.new :db => Mongoid.database
    c.url_host = 'http://0.0.0.0:9292/media'
  end
  app.define_macro_on_include(Mongoid::Document, :image_accessor)

  Dir.open("./models").each do |file|
    next if file =~ /^\./
    require "./models/#{file}"
  end

  configure :development do
    register Sinatra::Reloader
    also_reload "#{Dir.pwd}/models/*"
  end

  before do
    content_type 'application/json'
  end

  get '/media/:job' do |job|
    # TODO: Implement caching?
    job = Dragonfly::Job.deserialize(job, app)
    response = Dragonfly::Response.new(job, env)
    catch(:halt) do
      response.to_response
    end
  end
end

require_relative 'helpers'
require_relative 'routes/init'