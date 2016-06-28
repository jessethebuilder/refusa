def pre_query_url
  "http://www.referenceusa.com.ezproxy.#{library_name}.net/Home/Home"
end

def navigate_to_query_page
  # Move the the Advanced Search People Page
  visit pre_query_url unless is_pre_query_page?
 
   page.execute_script %Q{
     jQuery(".search").css({visibility: 'visible'});
     jQuery(".search").find("a").css({visibility: 'visible'});
   }
  
  case @search_type
    when :people
      url_part = 'UsConsumer'
    when :business
      url_part = 'UsBusiness'
  end
  
  first("a[href='/#{url_part}/Search']").click
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

def wait_until_query_is_ready
  wait_until do
    page.has_css?('#phCounty') 
  end
    
  %w|phCityState phMetroArea phZipCode phCounty|.each do |e|  
    wait_until do
      within(:css, "##{e}") do
        page.has_css?('.groupbox')
      end
    end
  end
end

def prepare_query_page
  wait_until{ page.has_css?('#cs-CityState') }
  
  check 'cs-CityState'
  check 'cs-ZipCode'
  check 'cs-MetroArea'
  check 'cs-County'
  
  wait_until_query_is_ready
  

  fill_state_combo_box
  
  set_status("Please Select #{@search_type.to_s.upcase} Search State")
end

def start_query(type)
  @search_type = type
  navigate_to_query_page
  # F.write('temp.txt', page.html)
  prepare_query_page
end

def is_pre_query_page?
  page.current_url =~ /\/Home\/Home$/
end

def update_state
  if @states
    val = @state_combo_box.getSelectedItem
    unless val == ""
      update_select('#availableCityState', @states.index(val))
    end
  end
end

def update_select(box, index)  
  puts index
  
  # wait_until{ page.has_css?('#availableCityState') }
  wait_until{ noko_page.search("#{box} .arrowTag").count == 58 }

  arrow = find("#{box} .arrowTag:nth-child(#{index + 1})")
  
  arrow.click unless arrow.has_css?('.expanded')
  
  
  child_box = "#{box}"
  wait_until{ 
    puts 'w'
    page.has_css?("#{child_box}")}
  # wait_until do
    # puts 'w'
    # puts child_box
    # puts page.current_url
    # # puts all("#availableCityState .dataLi::nth-child(#{index + 1}) .childDiv ul li").count
    # # page.has_css?(child_box)
  # end
  puts 'done'
  sleep 5
  
  F.write('html.html', page.html)
  
  items = noko_page.search("#{child_box} .label").map{ |i| i.text }
  
  
  @city_combo_box.add_item('')

  items.each do |i|
    @city_combo_box.add_item(i)
  end
end