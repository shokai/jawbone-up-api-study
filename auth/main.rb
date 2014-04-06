def app_root
  "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}#{env['SCRIPT_NAME']}"
end

def oauth_client
  @client ||= OAuth2::Client.new(CLIENT_ID, APP_SECRET,
                                 :site => 'https://jawbone.com',
                                 :authorize_url => '/auth/oauth2/auth',
                                 :token_url => '/auth/oauth2/token')
end

get '/' do
  unless session[:oauth_token]
    @mes = %Q{<p><a href="/login">login</a></p>}
  else
    @mes = %Q{<p><a href="/logout">logout</a></p>
<p>your token : #{session[:oauth_token]}</p>}
  end
end

get '/login' do
  scope = "basic_read extended_read mood_read move_read sleep_read generic_event_read"
  redirect oauth_client.auth_code.authorize_url(:scope => scope,
                                                :redirect_uri => "#{app_root}/auth")
end

get '/auth' do
  code = params["code"]
  halt 400, 'code missing' unless code
  begin
    session[:oauth_token] = oauth_client.auth_code.get_token(code).token
    puts "TOKEN : "+session[:oauth_token]
  rescue => e
    STDERR.puts e.message
  end
  redirect "/"
end

get '/logout' do
  session.delete :oauth_token
  redirect "/"
end

post '/pubsub' do
  request.body.rewind
  puts request.body.read
  "ok"
end
