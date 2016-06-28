module ScrapeUtilities    
  def wait_until
    #expects block
    while true
      sleep 1
      return if yield
    end
  end
end
