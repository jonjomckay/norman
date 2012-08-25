require 'rubygems'
require 'bundler'

Bundler.require

Mongoid.load!("config/mongoid.yml")

use Rack::Cache,
  :verbose     => true,
  :metastore   => URI.encode("file:/tmp/dragonfly/cache/meta"), # URI encoded in case of spaces
  :entitystore => URI.encode("file:/tmp/dragonfly/cache/body")

require './app'
run Norman