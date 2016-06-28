require_relative 'walker/search_page'
require_relative 'walker/query'
require_relative 'walker/search'
require_relative 'walker/login'

def wait_until
  #expects block
  
  while true
    sleep 1
    return if yield
  end
end

def noko_page
  Nokogiri::HTML.parse(page.html)
end

def library_name
   /\/ezproxy\.(.+?)\./.match(@login_protocol[:url])[1]
end
