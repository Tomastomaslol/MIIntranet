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
      session[:last_visit] = cookie_values
      add_value_to_cookie(DateTime.now)
    else
      create_cookie
      add_value_to_cookie(DateTime.now)
      session[:last_visit] = '2012-09-01T00:00:00+01:00'
    end
  end
end
