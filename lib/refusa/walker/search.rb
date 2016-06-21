def click_state_link (state)
  index = @states.index(state)
  
  within('#availableCityState') do
    first(:xpath,"//*[text()='#{state}']").click
    # find(".label:nth-child(#{index})").click  
  end
end

def set_search_parameters
  h = search_parameters
  
  if ignore_state?(h)
    adf
  else
    click_state_link(h['state'])
  end
end

def do_refusa_search
  set_search_parameters
  click_link 'View Results'
end


def refusa_search
  do_refusa_search
  
  wait_until{ page.has_css?('.action-view-record') }
  
  index_page = SearchIndexPage.new(page)
  index_page.follow_and_parse_pages!
  
  # @debug.set_text(index_page.page.html)
end

def ignore_state?(parameters)
  %w|city county metro_area zip|.each do |key|
    v = parameters[key]
    return true if v.to_s != ''
  end
  
  false
end

def search_parameters
  h = {}
  h['state'] = @state_combo_box.get_selected_item
  h['city'] = @city_combo_box.get_selected_item
  h['county'] = @county_combo_box.get_selected_item
  h['metro_area'] = @metro_area_combo_box.get_selected_item
  h['zip'] = @zip_field.get_text
  h
end