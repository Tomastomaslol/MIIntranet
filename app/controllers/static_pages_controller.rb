class StaticPagesController < ApplicationController
  before_filter :ensure_signed_in, only: :useful
  
  def home
    if signed_in?
      @event = current_user.events.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def useful
    if cookie_exists?
      add_to_session_value(cookie_values)
      add_to_cookie_value(DateTime.now)
    else
      create_cookie
      add_to_session_value('2012-07-01T00:00:00+01:00')
    end
  end
  
  
  private
  def create_cookie
    cookies[:last_visit_datetime] = 
    {
      :value => DateTime.now,
      :expires => 1.month.from_now
    }
  end
  
  def cookie_exists?
    cookies[:last_visit_datetime].present?
  end
  
  def cookie_values
    cookies[:last_visit_datetime]
  end
  
  def add_to_session_value(value)
    session[:last_visit] = value
  end
  
  def add_to_cookie_value(value)
    cookies[:last_visit_datetime] = value
  end
end
