class MainForm < JFrame
  attr_accessor :city_combo_box, :state_combo_box, :metro_area_combo_box, :county_combo_box, :zip_field, :debug, :search_count_label,
                :dump_people_button, :dump_businesses_button
  # include Capybara::DSL
  # include ScrapeUtilities
  
  def initialize 
    begin
    super('Ref USA!')
    rescue => e
      puts 'dead'
      System.exit(0)
    end
        
    set_size(600, 400)
    set_visible(true)
    set_default_close_operation(JFrame::EXIT_ON_CLOSE)

    @walker = LibWalker.new(self)
    
    status_panel
    main_panel
    debug_panel  
    
    
    #DEBUG =----------------------------------------------------------=========############################
    # @walker.instance_variable_set(:@search_type, :people)
    # @walker.login_user
  end
  
  
  
  
  #------- Main Panel ------------------------
  def main_panel
    set_db
    m = JPanel.new
    m.set_layout(GridLayout.new(9,3, 10, 5))
    
    login_fields(m)
    query_select_fields(m)
    
    people_query_fields(m)
    
    search_button_row(m)
    
    options_button_rows(m)
    
    get_content_pane.add(m, BorderLayout::NORTH)  
    
    @main_panel = m
    m
  end
  
  def search_button_row(panel)
    
    count_button = panel.add(JButton.new('Count'))
    count_button.add_action_listener do
      @walker.show_count
    end
  
    @search_count_label = JLabel.new('Count: ')
    panel.add(@search_count_label)
  
    search_button = JButton.new('Search')
    search_button.add_action_listener do 
      @walker.search
    end
    panel.add(search_button)
  
    
  end
  
  def options_button_rows(panel)
    dump_people_button = JButton.new("People (#{@walker.entry_count(:people)})")
    dump_people_button.add_action_listener do 
      dump(:people)
    end
    panel.add(dump_people_button)
    
    dump_businesses_button = JButton.new("Businesses (#{@walker.entry_count(:businesses)})")
    dump_businesses_button.add_action_listener do 
      nil
    end
    panel.add(dump_businesses_button)
    
    reset_button = JButton.new('Reset')
    panel.add reset_button
    reset_button.add_action_listener do
      @walker.reset_search
    end    
  end
  
  def dump(type)
    csv = CSV.generate do |c|
      @walker.db[type].each do |r|
        c << r.values
      end
    end
    
    file_name = "#{type.to_s}_#{Time.now.strftime('%m-%d-%y_%H-%M')}.csv"
    F.write(file_name, csv)
    set_status("#{file_name} Saved!")
    @walker.db[type].delete
    update_dump_button(type)
  end
  
  def update_dump_button(type)
    send("dump_#{type}_button").set_text("#{type.capitalize} (#{@walker.entry_count(type)})")
  end
      
  
  #---------------- Status Panel -------------
  def status_panel
     panel = JPanel.new
     @status_panel_label = JLabel.new('Please Login', JLabel::CENTER)
     get_content_pane.add(@status_panel_label, BorderLayout::SOUTH)
  end
  
  def set_status(status)
    @status_panel_label.setText(status)
  end
  
  def debug_panel
    @debug = JTextArea.new()    
    get_content_pane.add(@debug)
  end

end

