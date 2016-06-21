#!/usr/bin/env ruby

require_relative '../lib/refusa/config'
require_relative '../lib/refusa/db'
require_relative '../lib/refusa/walker'
require_relative '../lib/refusa/views'

require 'refusa'

class Refusa
  
  
  def initialize
    start_main_form
  end
 
  def start_main_form
    SwingUtilities.invoke_later do
      begin
        f = MainForm.new
        
        # temp
        # f.send(:login_user, @user_id_fieldf.login_url)
        # f.send(:start_people_search)
      ensure
        @db.close if @db
      end
    end 
  end


end

def main
  Refusa.new
end

main