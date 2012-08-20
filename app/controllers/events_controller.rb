class EventsController < ApplicationController
  before_filter :ensure_signed_in, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def index
  end

  def create
    @event = current_user.events.build(params[:event])
    if @event.save
      flash[:success] = "Event added"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end unless @event.name.nil?
  end

  def destroy
    @event.destroy
    redirect_to root_url
  end
  
  private
    def correct_user
      @event = current_user.events.find_by_id(params[:id])
      redirect_to root_url if @event.nil?
    end
  
end
