class SearchIndexPage
  def initialize(index_page)
    @page = index_page
  end
  
  def follow_and_parse_pages!
    page_count = 1
    # = @page.search('.action-view-record')
    i = 1
    
    @page.within('#searchResultsPage') do
      while(i <= page_count)
        if i.odd?
          @page.find("tr:nth-child(#{i})").first('a').click
          p = SearchPage.new(@page)
        end
        i = i + 1
      end
    end
  end
end