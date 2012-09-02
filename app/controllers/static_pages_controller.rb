class StaticPagesController < ApplicationController
  before_filter :ensure_signed_in, only: :useful
  
  def home
    if signed_in?
      @event = current_user.events.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def useful
  end
end
