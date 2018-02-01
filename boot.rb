require 'rubygems'
require 'bundler'

Bundler.require

require 'sinatra/base'
require 'sinatra/activerecord'

autoload_dirs = %w[
  models
]

autoload_dirs.each do |dir|
  Dir[File.join(File.expand_path(File.dirname(__FILE__)), dir, '**', '*.rb')].each { |f| require f }
end

