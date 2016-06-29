require_relative 'modules/walker'
require_relative 'walker/results_page'
require_relative 'walker/query'
require_relative 'walker/search'
require_relative 'walker/login'

class LibWalker < Walker  
  attr_accessor :db
  
  def initialize(form)
    @form = form
    set_db
  end
  
  def entry_count(type)
    @db[type].count
  end
    
  def library_name
    /\/ezproxy\.(.+?)\./.match(@login_protocol[:url])[1]
  end
  
  def wait_for_origin_loading
    wait_until_search_box_updates
  end
  
  def wait_until_search_box_updates    
    wait_until{ !page.has_css?('.originLoading') }
  end
end