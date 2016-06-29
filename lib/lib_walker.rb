require_relative 'modules/walker'
require_relative 'walker/search_page'
require_relative 'walker/query'
require_relative 'walker/search'
require_relative 'walker/login'

class LibWalker < Walker
  def library_name
    /\/ezproxy\.(.+?)\./.match(@login_protocol[:url])[1]
  end
  
  def wait_until_search_box_updates    
    wait_until{ !page.has_css?('.originLoading') }
  end
end