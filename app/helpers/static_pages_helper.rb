require 'rss/1.0'
require 'rss/2.0'
require 'open-uri'

module StaticPagesHelper
  
  def blog_feed
    source = "http://pipes.yahoo.com/pipes/pipe.run?_id=3575bea4a05235f2b3812bfcbf8f55c2&_render=rss" # url or local file
    content = "" # raw content of rss feed will be loaded here
    open(source) do |s| 
      content = s.read 
    end
    rss = RSS::Parser.parse(content, false)
    html = raw("<ul>")
    rss.items.first(100).each do |i|
      html << raw("<li>")
      html << raw("<a href='#{i.link}'>#{i.title}</a> - #{i.date.strftime("%H:%M, %d %b %y")}</li>")
    end
    html << raw("</ul>")
  end
end


#@users = User.paginate(page: params[:page])




#html << "</ul>"
#html