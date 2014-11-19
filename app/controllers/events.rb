get "/events/new" do 
  erb :"event_views/new"
end

get "/events/edit/:event_id" do 
  @event = Event.find(params[:event_id])
  if @event.user_id == current_user_id
    erb :"event_views/edit", layout: !request.xhr?
  else
    @errors = {:Invalid => ["You can't edit that event event!!!"]}
    redirect to "/"
  end
end

get '/events/delete/:event_id' do
  @event = Event.find(params[:event_id])
  if @event.user_id == current_user_id
    @event.destroy
    if request.xhr?
      return erb :"user_views/show", layout: false
    end
    redirect to "/users/show"
  else
    redirect to "/"
  end
end

post "/events/new" do 
  params[:event][:user_id] = current_user_id
  @event = Event.new(params[:event])
  if @event.save
    redirect to '/users/show'
    @errors = {:Great => ["Your event has been created"]}
  else
    @errors = {:Invalid => ["Something went wrong with the creation of your event!!!"]}
    redirect to '/events/new'
  end
end

post "/events/edit/:event_id" do 
  @event = Event.find(params[:event_id])
  @event.update(params[:event])
  if @event.save
    @errors = {:Great=> ["Your changes have been added"]}
    if request.xhr?
      return erb :"user_views/show", layout: false
    end
    redirect to "/users/show"
  else
    @errors = {:Invalid => ["Something went wrong, we were unable to save the changes of your event!!!"]}
    redirect to ("/events/edit/#{@event.id}")
  end
end