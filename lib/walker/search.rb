class LibWalker < Walker
  def search
    set_search_parameters
    page.click_link 'View Results'
    wait_until{ page.has_css?('.action-view-record') }
    @form.debug.set_text(page.html)
    F.write('x.html', page.html)
    
    
    # index_page = SearchIndexPage.new(page)
    # index_page.follow_and_parse_pages!
    
  end
 
  def show_count
    F.write('h.html', page.html)
    set_search_parameters
    page.click_link('Update Count')
    @form.search_count_label.set_text("Count: #{get_count}")  
  end
  
  def reset_search
    click_link 'Clear Search'
    wait_until_search_box_updates
    reset_query
  end
  
  def set_search_parameters
    p = search_parameters
    
    if @form.zip_field.get_text != ''
      set_zip_search
    else
      set_state_search
    end
  end
  
  def set_state_search
    click_state_link
    wait_until_query_is_ready
  end
  
  def set_zip_search
    uncheck_all_query_boxes('cs-ZipCode')
    zips = @form.zip_field.get_text.split(' ')[0..9]
    zips.each_with_index do |zip, n|
      page.fill_in "inputGrid#{n + 1}", :with => zip
    end
  end
  
  def click_state_link
    val = @form.state_combo_box.get_selected_item
    unless val == ''
      page.within('#availableCityState') do
        page.first(:xpath,"//*[text()='#{val}']").click
      end
    end
  end
  
  private 
  
  def get_count
    wait_until_search_box_updates
    page.find('.totalCount').text
  end
  
  def search_parameters
    h = {}
    h['state'] = @form.state_combo_box.get_selected_item
    h['city'] = @form.city_combo_box.get_selected_item
    h['county'] = @form.county_combo_box.get_selected_item
    h['metro_area'] = @form.metro_area_combo_box.get_selected_item
    h['zip'] = @form.zip_field.get_text
    h
  end
  

end