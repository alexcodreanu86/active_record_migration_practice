get '/users/new' do 
  erb :"user_views/sign_up", layout: !request.xhr?
end

get '/users/login' do
  erb :"user_views/login", layout: !request.xhr?
end

get '/users/show' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    @events = @user.created_events
    erb :"user_views/show"
  else
    @errors = {:Invalid => ["Not logged in yet"]}
    erb :index
  end
end


get "/users/logout" do 
  session.clear
  redirect to('/')
end


post '/users/new' do
  @user = User.create(params[:user])
  redirect to('/')
end

post '/users/login' do
  @user = User.find_by(email: params[:email])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect to('/users/show')
  else
    @errors = {:Invalid => ["Invalid email or password"]}
    erb :"user_views/login"
  end
end




