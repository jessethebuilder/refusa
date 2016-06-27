def login_protocol
  @login_protocol ||= LOGIN_PROTOCOLS.first
end

def login_user
  visit @login_protocol[:url]
  fill_in @login_protocol[:user_id_selector], :with => @login_protocol[:user_id]
  
  if @login_protocol.key?(:pin)
    fill_in @login_protocol[:pin_selector], :with => @login_protocol[:pin]
  end
  
  click_button @login_protocol[:submit_text]  
  post_login
end

def post_login
  set_status('Please Select People or Business Search')
end  


::LOGIN_PROTOCOLS = [
  {:name => 'Pasadena', 
    :url => 'http://ezproxy.pasadenapubliclibrary.net/login?url=http://www.referenceusa.com/login',
    :user_id => '29009016461368',
    :user_id_selector => 'user',
    :submit_text => 'Login'},
  {:name => 'SF', 
    :url => 'http://ezproxy.sfpl.org/login?url=http://www.referenceusa.com/login',
    :user_id => '21223202546787',
    :user_id_selector => 'barcode',
    :pin => '1216',
    :pin_selector => 'pin', 
    :submit_text => 'Submit'
   }
]
