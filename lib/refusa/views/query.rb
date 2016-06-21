def query_select_fields(panel)
  panel.add(JLabel.new('Search Type : ', JLabel::CENTER))

  people_button = JButton.new('People Search')
  people_button.add_action_listener do |e|
    start_people_search
    # @debug.set_text(page.html)
  end
  
  panel.add(people_button)
  
  
  business_button = JButton.new('Business Search')
  business_button.add_action_listener do |e|
    nil
  end
  panel.add(business_button)
end

#----------- PEOPLE -----------------------

def people_query_fields(panel)
  panel.add(JLabel.new('State : ', JLabel::CENTER))
  @state_combo_box = JComboBox.new 
  @state_combo_box.add_action_listener do
    update_state   
  end
  panel.add(@state_combo_box)
  panel.add(JLabel.new(''))
  
  panel.add(JLabel.new('City : ', JLabel::CENTER))
  panel.add(@city_combo_box = JComboBox.new)
  panel.add(JLabel.new(''))
  
  panel.add(JLabel.new('Metro Area : ', JLabel::CENTER))
  panel.add(@metro_area_combo_box = JComboBox.new)
  panel.add(JLabel.new(''))
  
  panel.add(JLabel.new('County : ', JLabel::CENTER))
  panel.add(@county_combo_box = JComboBox.new)
  panel.add(JLabel.new(''))
  
  panel.add(JLabel.new('Zip : ', JLabel::CENTER))
  panel.add(@zip_field = JTextField.new())
  panel.add(JLabel.new(''))
end