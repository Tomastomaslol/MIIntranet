class EventsController < ApplicationController
  before_filter :ensure_signed_in, only: [:create, :destroy, :edit, :update]
  before_filter :correct_user, only: [:destroy, :edit, :update]

  def show
    @event = Event.find_by_id(params[:id])
    @user = User.find(@event.user_id)
  end

  def create
    @event = current_user.events.build(params[:event])
    user = current_user 
    user.events << @event
    if @event.save
      flash[:success] = "Event added"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end unless @event.name.nil?
  end

  def destroy
    came_from = request.referrer
    @event.destroy
    flash[:notice] = "Event deleted"
    if came_from.include?('/events/')
      redirect_to calendar_path
    else
      redirect_to came_from
    end
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    
    if @event.update_attributes(params[:event])
      flash[:success] = "Event updated"
      redirect_to @event
    else
      render 'edit'
    end
  end
  
  
  private
    def correct_user
      @event = current_user.events.find_by_id(params[:id])
      redirect_to root_url if @event.nil?
    end
  
end
