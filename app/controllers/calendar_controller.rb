class CalendarController < ApplicationController
  before_filter :ensure_signed_in
  def index
    @month = (params[:month] || (Time.zone || Time).now.month).to_i
    @year = (params[:year] || (Time.zone || Time).now.year).to_i

    @shown_month = Date.civil(@year, @month)

    @first_day_of_week = 1 #Add firstdayofweek array to brackets below, after shown_month
    
    #Add everyone else to users list
    ownerships_user_id_list = Relationship.where(:follower_id => current_user.id).map(&:"followed_id")
                          
    #Add self to users list
    ownerships_user_id_list.push(current_user.id)

    @event_strips = Event.event_strips_for_month(@shown_month, @first_day_of_week,
                      :include=> :ownerships, :conditions => ['ownerships.user_id in (?)',ownerships_user_id_list]) 
    
  end
  
end




  