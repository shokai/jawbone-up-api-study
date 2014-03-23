require 'jawbone'
require 'awesome_print'

OAUTH_TOKEN = ENV["JAWBONE_TOKEN"]

client = Jawbone::Client.new OAUTH_TOKEN

p client.user

sleep 1

ap client.sleeps

