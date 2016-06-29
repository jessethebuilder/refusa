class ResultsPage
  def initialize(page, search_type, db)
    # Page is Nokogiri 
    @page = page
    @search_type = search_type
    @db = db
  end
  
  def parse_and_save
    rows = @page.search('#searchResultsPage tr')
    rows.each do |r|
      save_from_row(r)
    end
  end
  
private

  def save_from_row(row)
    h = {}
    cols = row.search('td')
    if @search_type == :people
      h[:first_name] = cols[1].text
      h[:last_name] = cols[2].text
    elsif @search_type == :business
      h[:name] = cols[1].text
      h[:executive_name] = cols[2].text
    end
    h[:street] = cols[3].text
    city_state = cols[4].text.split(', ')
    h[:city] = city_state[0]
    h[:state] = city_state[1]
    h[:zip] = cols[5].text
    h[:phone] = cols[6].text
    
    @db[@search_type].insert(h)
  end
end