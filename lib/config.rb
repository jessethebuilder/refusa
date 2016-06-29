# require 'capybara'
# # require 'capybara/dsl'
# require 'capybara/poltergeist'
# require 'nokogiri'
require 'jdbc/sqlite3'
require 'sequel'

require_relative 'modules/f'
require_relative 'modules/scrape_utilities'


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

puts ENV.inspect

class Refusa
  include Java
end 



