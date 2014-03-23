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
  scope = "extended_read sleep_read mood_read"
  redirect oauth_client.auth_code.authorize_url(:scope => scope,
                                                :redirect_uri => "http://localhost:5000/auth")
end

get '/auth' do
  code = params["code"]
  halt 400, 'code missing' unless code
  begin
    session[:oauth_token] = oauth_client.auth_code.get_token(code).token
  rescue => e
    STDERR.puts e.message
  end
  redirect "/"
end

get '/logout' do
  session.delete :oauth_token
  redirect "/"
end
