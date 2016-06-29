class MainForm < JFrame
  def login_fields(panel)
    panel.add(JLabel.new('Login Protocol : ', JLabel::CENTER))
    
    # @user_id_field = JTextField.new('29009016461368')
    # panel.add(@user_id_field)
    
    protocol_box = JComboBox.new()
    protocol_box.add_action_listener do |e|
      LOGIN_PROTOCOLS.each do |p|
        # puts e.inspect
        if p[:name] == protocol_box.get_selected_item
          @walker.login_protocol = p
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
      @walker.login_user
    end  
    panel.add(login_button)
  end
end
