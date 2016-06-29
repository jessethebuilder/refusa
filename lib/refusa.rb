require_relative 'config'
require_relative 'db'
require_relative 'lib_walker'
require_relative 'views'

# require 'refusa'

class Refusa
  def initialize
    start_main_form
  end
 
  def start_main_form
    SwingUtilities.invoke_later do
      begin
        f = MainForm.new
      # rescue Exception => e
        # puts e
        # F.log_error(e)
        # System.exit(0)
      ensure
        @db.close if @db
      end
    end 
  end
end