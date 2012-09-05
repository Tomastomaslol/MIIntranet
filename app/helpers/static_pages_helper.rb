require 'rss/1.0'
require 'rss/2.0'
require 'rss'
require 'open-uri'

module StaticPagesHelper
  
  def blog_feed_old(list_length = 50)
    source = "http://pipes.yahoo.com/pipes/pipe.run?_id=3575bea4a05235f2b3812bfcbf8f55c2&_render=rss" # url or local file
    content = "" # raw content of rss feed will be loaded here
    open(source) do |s| 
      content = s.read 
    end
    rss = RSS::Parser.parse(content, false)
    html = raw("<ul>")
    rss.items.first(list_length).each do |i|
      if i.date.to_f > session[:last_visit]
        html << raw("<li class='rss-unread'>")
        html << raw("#{i.date.strftime("%d %b %y, %H:%M")} - <a href='#{i.link}'>#{i.title}</a></li>")
      else
        html << raw("<li class='rss-read'>")
        html << raw("#{i.date.strftime("%d %b %y, %H:%M,")} - <a href='#{i.link}'>#{i.title}</a></li>")
      end
    end
    html << raw("</ul>")
  end
    
    
  def blog_feed(list_length = 50)

    rss = RSS::Parser.parse(open("http://pipes.yahoo.com/pipes/pipe.run?_id=3575bea4a05235f2b3812bfcbf8f55c2&_render=rss").read, false)
    
    html = raw("<ul>")
    rss.items.first(list_length).each do |i|
      if i.date.to_f > session[:last_visit].to_f
        html << raw("<li class='rss-unread'>")
        html << raw("#{i.date.strftime("%d %b %y, %H:%M")} - <a href='#{i.link}'>#{i.title}</a></li>")
      else
        html << raw("<li class='rss-read'>")
        html << raw("#{i.date.strftime("%d %b %y, %H:%M,")} - <a href='#{i.link}'>#{i.title}</a></li>")
      end
    end
    html << raw("</ul>")
  end
  
end