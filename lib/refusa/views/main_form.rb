class MainForm < JFrame
  include Capybara::DSL
  

  
  def initialize 
    super('Ref USA!')
    
    set_size(600, 400)
    set_visible(true)
    set_default_close_operation(JFrame::EXIT_ON_CLOSE)
    
    status_panel
    main_panel
    debug_panel  
    
  end
  
  #------- Main Panel ------------------------
  def main_panel
    db
    
    
    m = JPanel.new
   
   
    m.set_layout(GridLayout.new(8,3, 10, 5))
    # m.set_layout(BorderLayout.new(10, 10))
  
  

   
  
    login_fields(m)
    query_select_fields(m)
    
    people_query_fields(m)
    
    search_button_row(m)
    
    get_content_pane.add(m, BorderLayout::NORTH)  
    
    
    @main_panel = m
  end
  
  def login_fields(panel)
    panel.add(JLabel.new('Login Protocol : ', JLabel::CENTER))
    
    # @user_id_field = JTextField.new('29009016461368')
    # panel.add(@user_id_field)
    
    protocol_box = JComboBox.new()
    protocol_box.add_action_listener do |e|
      LOGIN_PROTOCOLS.each do |p|
        # puts e.inspect
        if p[:name] == protocol_box.get_selected_item
          @login_protocol = p
          break
        end     
      end
    end
    
    LOGIN_PROTOCOLS.each do |p|
      protocol_box.add_item p[:name]
    end
    panel.add(protocol_box)
    
    login_button = JButton.new('Login')  
    login_button.add_action_listener do |e|
      login_user
    end  
    panel.add(login_button)
  end
  
  def search_button_row(panel)
    panel.add(JLabel.new())

    @search_button = JButton.new('Search')
    @search_button.add_action_listener do 
      refusa_search
    end
    panel.add(@search_button)

    @dump_button = JButton.new('Dump')
      @dump_button.add_action_listener do 
        nil
      end
    panel.add(@dump_button)
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

