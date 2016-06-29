require_relative 'scrape_utilities'
require 'capybara'
require 'capybara/poltergeist'
require 'nokogiri'

module Cliver
  class ShellCapture
    def initialize(_command)
      @stderr = ''
      @stdout = '2.1.1'
      @command_found = true
    end
  end
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {:phantomjs => File.absolute_path('..\..\vendor\phantomjs\bin\phantomjs.exe'), 
                                          :timeout => 120, :debug => true})
  # Capybara::Poltergeist::Driver.new(app, {:timeout => 120, :debug => false})                                          
end
Capybara.default_driver = :poltergeist  

class Walker 
  include ScrapeUtilities
  
  def session
    @session ||= Capybara::Session.new(:poltergeist)
  end
  
  def destroy_session
    @session = nil
  end
  
  def page
    session
  end
  
  def noko_page
    Nokogiri::HTML.parse(session.html)
  end
  
  private
  
  def set_session
    @session = Capybara::Session.new(:poltergeist)
    @session.driver.browser.js_errors = false
  end
end