class MainForm < JFrame
  attr_accessor :city_combo_box, :state_combo_box, :metro_area_combo_box, :county_combo_box, :zip_field, :debug, :search_count_label
  # include Capybara::DSL
  # include ScrapeUtilities
  
  def initialize 
    begin
    super('Ref USA!')
    rescue => e
      puts 'dead'
      System.exit(0)
    end
    
    @walker = LibWalker.new(self)
    
    set_size(600, 400)
    set_visible(true)
    set_default_close_operation(JFrame::EXIT_ON_CLOSE)
    
    status_panel
    main_panel
    debug_panel  
    
    #DEBUG =----------------------------------------------------------=========############################
    @walker.instance_variable_set(:@search_type, :people)
    @walker.login_user
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
    dump_button = JButton.new('Dump')
      dump_button.add_action_listener do 
        nil
      end
    panel.add(dump_button)
    
    panel.add(JLabel.new(''))
   
    reset_button = JButton.new('Reset')
    panel.add reset_button
    reset_button.add_action_listener do
      @walker.reset_search
    end
    
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

