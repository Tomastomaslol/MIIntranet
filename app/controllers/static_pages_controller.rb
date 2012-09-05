class StaticPagesController < ApplicationController
  before_filter :ensure_signed_in, only: [:rss, :useful]
  
  def home
    if signed_in?
      @event = current_user.events.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def rss
    if cookie_exists?
      add_to_session_value(cookie_values) unless (cookie_values.to_f - session_values.to_f < 300)
      add_to_cookie_value(DateTime.now.to_f)
    else
      create_cookie
      add_to_session_value((DateTime.now - 1.month).to_f)
    end
  end
  
  def useful
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
  
  def session_values
    session[:last_visit]
  end
  
  def add_to_session_value(value)
    session[:last_visit] = value
  end
  
  def add_to_cookie_value(value)
    cookies[:last_visit_datetime] = value
  end
end
