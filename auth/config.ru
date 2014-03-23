require 'sinatra'
require 'oauth2'

CLIENT_ID  = ENV["CLIENT_ID"]
APP_SECRET = ENV["APP_SECRET"]

require_relative 'main'

enable :sessions
set :session_secret, (ENV["SESSION_SECRET"] || "zanmai-kazusuke-kazudon-marutaka")

run Sinatra::Application
