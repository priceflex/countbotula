require 'rubygems'
require "awesome_print"
require 'csv'
require 'googlecharts'

puts "Enter Client Name:"
client_name = gets
current_time = Time.now.strftime("%m-%d-%Y")


# {:computer_name => "Operations-03"}
# import csv file

  blocked_dns = []
  
  CSV.foreach('opendnsfile.csv') do |row|
    # ap row
    blocked_dns << row[2]

  end
  # Delete the Header from array
  blocked_dns.delete_at(0)
  
  # Put all the comptuers into an array and make it unique
  unique_computers = blocked_dns.uniq
  

  # counts each blocked dns requtes for each computer
  dirty_computer = unique_computers.map {|computer| {computer => blocked_dns.count(computer)}}

  # This will save to file
  # CSV.open("#{client_name}-#{current_time}.csv", 'w') do |csv_object|
  #     csv_object << dirty_computer.map{|computer| computer.keys.first}
  #     csv_object << dirty_computer.map{|computer| computer.values.first}
  #   end

  ap dirty_computer
  ap dirty_computer.map{|computer| [computer.values.first]}
  ap dirty_computer.map{|computer| [computer.keys.first]}
  

  chart = Gchart.new( :type => 'bar',
                      :title => "#{client_name} - Number of Blocked Malware Requests #{current_time}",
                      :theme => :keynote,
                      :data => dirty_computer.map{|computer| computer.values.first}, 
                      :line_colors => 'e0440e,e62ae5,287eec',
                      :legend => dirty_computer.map{|computer| [computer.keys.first]},
                      :labels => dirty_computer.map{|computer| [computer.keys.first]},
                      :axis_with_labels => ['x', 'y'], 
  					          :stacked => false,
                      :filename => "chart.png",
                      :size => "700x500")
                      
  # Record file in filesystem
  chart.file

