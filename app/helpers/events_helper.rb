module EventsHelper
  
  def owner_of(event)
    full_name_for(User.find(event.user_id))
  end
  
end
