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

def accept_terms
  if /\/Static\/Home$/ =~ page.current_path
    check 'chkAgree' 
    page.find(:css, '.action-agree').click 
    
    fill_in 'matchcode', :with => @login_protocol[:user_id]
    page.find(:css, '.action-submit-form').click
  end
end

def post_login
  accept_terms
  unless @search_type
    set_status('Please Select People or Business Search')
  else
    start_query(@search_type)
  end
end  


