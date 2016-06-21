def pre_query_url
  'http://www.referenceusa.com.ezproxy.pasadenapubliclibrary.net/Home/Home'
end

def navigate_to_people_query_page
  # Move the the Advanced Search People Page
  visit pre_query_url unless is_pre_query_page?
  
   page.execute_script %Q{
     $(".search").css({visibility: 'visible'});
     $(".search").find("a").css({visibility: 'visible'});
   }
  
  first("a[href='/UsConsumer/Search']").click
  find('.advancedSearch').click  
end  

def fill_state_combo_box
  @state_combo_box.add_item('')
  
  results = noko_page.search('#availableCityState .dataLi .label')
  
  @states = results.map{ |r| r.text }
  
  @states.each do |r|
    @state_combo_box.add_item(r)
  end
end

def prepare_query_page
  check 'cs-CityState'
  check 'cs-ZipCode'
  check 'cs-MetroArea'
  check 'cs-County'
  
  sleep 5
  fill_state_combo_box
  
  set_status('Please Select Search Parameters')
end

def start_people_search
  set_status('Preparing People Search...')
  navigate_to_people_query_page
  prepare_query_page
end

def is_pre_query_page?
  page.current_url =~ /\/Home\/Home$/
end

def update_city(index)
  # @city_combo_box.add_item('')
  # within('#availableCityState') do
    # arrow = find(".action-toggle-arrow:nth-child(#{index + 1})")
    # unless arrow.has_css?('.expanded')
      # arrow.click 
      # sleep 5
    # end
  # end
#   
  # items = noko_page.search("#availableCityState .dataLi .label").map{ |i| i.text }
#   
  # items.each do |i|
    # @city_combo_box.add_item(i)
  # end
end

def update_state
  if @states
    index = @states.index(@state_combo_box.getSelectedItem)
    update_city(index)
  end
end