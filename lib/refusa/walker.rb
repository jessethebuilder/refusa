require_relative 'walker/search_page'
require_relative 'walker/query'
require_relative 'walker/search'

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

def login_url
  'http://ezproxy.pasadenapubliclibrary.net/login?url=http://www.referenceusa.com/login'
end

def login_user(user_id, url)
  visit url
  fill_in 'user', :with => user_id
  click_button 'Login'
  
  post_login
end

def post_login
  set_status('Please Select People or Business Search')
end