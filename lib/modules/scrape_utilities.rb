module ScrapeUtilities    
  def wait_until
    #expects block
    while true
      return if yield
      sleep 1
    end
  end
end
