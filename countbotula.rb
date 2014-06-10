require 'rubygems'
require "awesome_print"
require 'csv'

# {:computer_name => "Operations-03"}
# import csv file

#def import_data
  blocked_dns = []
  
  CSV.foreach('opendnsfile.csv') do |row|
    ap row
    blocked_dns << row[2]

  end
  # Delete the Header from array
  blocked_dns.delete_at(0)
  # Put all the comptuers into an array and make it unique
  unique_computers = blocked_dns.uniq
  
# end

# counts each blocked dns requtes for each computer
dirty_computer = unique_computers.map {|computer| {computer => blocked_dns.count(computer)}}

# opendns_data = [{}]

CSV.open('dirty_dirty_computers.csv', 'w') do |csv_object|
    csv_object << dirty_computer.map{|computer| computer.keys.first}
    csv_object << dirty_computer.map{|computer| computer.values.first}
  end



#import_data
