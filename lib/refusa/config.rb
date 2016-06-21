require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'nokogiri'
require 'jdbc/sqlite3'
require 'sequel'
# require 'activerecord'


import javax.swing.JFrame
import javax.swing.JComboBox
import javax.swing.JButton
import javax.swing.JPanel
import javax.swing.JLabel
import javax.swing.JTextField
import javax.swing.JTextArea
import javax.swing.JOptionPane

import java.lang.System

import java.awt.GridLayout
import java.awt.BorderLayout
import java.awt.Toolkit

import javax.swing.SwingUtilities

class Refusa
  include Java
 
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, {:phantomjs => File.absolute_path('..\..\vendor\phantomjs\bin\phantomjs.exe'), 
                                            :timeout => 120, :debug => true})
  end
  Capybara.default_driver = :poltergeist  
end 

module Cliver
  class ShellCapture
    def initialize(_command)
      @stderr = ''
      @stdout = '2.1.1'
      @command_found = true
    end
  end
end

