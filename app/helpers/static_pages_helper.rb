require 'rss/1.0'
require 'rss/2.0'
require 'rss'
require 'open-uri'

module StaticPagesHelper
  
  def blog_feed(list_length = 50)
    source = "http://pipes.yahoo.com/pipes/pipe.run?_id=3575bea4a05235f2b3812bfcbf8f55c2&_render=rss" # url or local file
    content = "" # raw content of rss feed will be loaded here
    open(source) do |s| 
      content = s.read 
    end
    rss = RSS::Parser.parse(content, false)
    html = raw("<ul>")
    rss.items.first(list_length).each do |i|
      if i.date > session[:last_visit]
        html << raw("<li class='rss-unread'>")
        html << raw("#{i.date.strftime("%d %b %y, %H:%M")} - <a href='#{i.link}'>#{i.title}</a></li>")
      else
        html << raw("<li class='rss-read'>")
        html << raw("#{i.date.strftime("%d %b %y, %H:%M,")} - <a href='#{i.link}'>#{i.title}</a></li>")
      end
    end
    html << raw("</ul>")
  end
    
    
  def blog_feed2(list_length = 50)
    #source = "http://www.moneysavingexpert.com/news/feeds/news.rss" # url or local file
    #content = "" # raw content of rss feed will be loaded here
    #open(source) do |s| 
    #  content = s.read 
    #end
    rss1 = RSS::Parser.parse(open("http://www.moneysavingexpert.com/news/feeds/news.rss").read, false)
    rss2 = RSS::Parser.parse(open("http://www.myintroducer.com/rss.asp").read, false)
    rss = rss1
    html = raw("<ul>")
    rss.items.first(list_length).each do |i|
      if i.date > session[:last_visit]
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