class LibWalker < Walker
  def pre_query_url
    "http://www.referenceusa.com.ezproxy.#{library_name}.net/Home/Home"
  end
  
  def navigate_to_query_page
    # Move the the Advanced Search People Page
    session.visit pre_query_url unless is_pre_query_page?
   
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
    
    session.first("a[href='/#{url_part}/Search']").click
    
    navigate_to_advanced_search  
  end  
  
  def navigate_to_advanced_search
    session.find('.advancedSearch').click
  end
  
  def reset_query
    @form.reset_query
    page.click_link 'Clear Search'
    # wait_until_query_is_ready
    uncheck_all_query_boxes
    check_all_query_boxes
  end
  
  def fill_state_combo_box
    @form.state_combo_box.add_item('')
    
    results = noko_page.search('#availableCityState .dataLi .label')
    
    @states = results.map{ |r| r.text }
    
    @states.each do |r|
      @form.state_combo_box.add_item(r)
    end
  end
  
  def prepare_query_page
    wait_until{ page.has_css?('#cs-CityState') }
    
    check_all_query_boxes
    
    wait_until_query_is_ready
    sleep 1
  
    fill_state_combo_box
    
    @form.set_status("#{@search_type.to_s.upcase} SEARCH")
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
    # if @states
      # val = @form.state_combo_box.get_selected_item
      # unless val == ""
        # update_select('#availableCityState', @states.index(val))
      # end
    # end
  end
  
  def update_select(box, index)  
    puts index
    
    # wait_until{ page.has_css?('#availableCityState') }
    wait_until{ noko_page.search("#{box} .arrowTag").count == 58 }
  
    arrow = session.find("#{box} .arrowTag:nth-child(#{index + 1})")
    
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
    
    
    @form.city_combo_box.add_item('')
  
    items.each do |i|
      @form.city_combo_box.add_item(i)
    end
  end

  
  private 
  
  def wait_until_query_is_ready    
    wait_until{ !page.has_css?('.originLoading') }
  end
  
  QUERY_CHECKBOXES = ['cs-CityState', 'cs-ZipCode', 'cs-MetroArea', 'cs-County']
  QUERY_BOXES = ['phCityState', 'phMetroArea', 'phCounty', 'phZipCode']
  
  def check_all_query_boxes
    QUERY_CHECKBOXES.each do |box|
      session.check box
    end
   
    QUERY_BOXES.each do |box|
      wait_until{ page.has_css?("##{box} div") }   
    end
  end
  
  def uncheck_all_query_boxes(except)
    arr = QUERY_CHECKBOXES
    arr.delete(except)
    arr.each do |box|
      session.uncheck box
    end
    
    QUERY_BOXES.each do |box|
      wait_until{ !page.has_css?("##{box} div") }   
    end
  end
end