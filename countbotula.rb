require 'rubygems'
require "awesome_print"
require 'csv'
require 'googlecharts'

puts "Enter Client Name:"
client_name = $stdin.gets
puts client_name
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
  name  = "#{client_name.to_sym}"
  file_name = "#{name}-#{current_time.to_s}.csv"
  CSV.open(file_name, 'w') do |csv_object|
      csv_object << dirty_computer.map{|computer| computer.keys.first}
      csv_object << dirty_computer.map{|computer| computer.values.first}
    end

  ap dirty_computer
  ap dirty_computer.map{|computer| computer.values.first}
  ap dirty_computer.map{|computer| computer.keys.first}
  ap dirty_computer.map{|computer| [computer.keys.first]}
  
  def create_random_color
    color = ""
    6.times do 
      if  [true, false].sample
        color << rand(10).to_s
      else
        color << ("a".."f").to_a.sample
      end
    end
    return color
  end
  
  def random_colors(colors=1)
    color_array = []
    colors.times do
      color_array << create_random_color
    end
    return color_array
  end
  

  chart = Gchart.new( :type => 'bar',
                      :title => "Blocked Malware Requests #{current_time}",
                      :theme => :keynote,
                      :data => dirty_computer.map{|computer| [computer.values.first]}, 
                      :line_colors => random_colors(dirty_computer.size),
                      :legend => dirty_computer.map{|computer| computer.keys.first},
                      # :label => dirty_computer.map{|computer| computer.key.first},
                      # :axis_with_labels => ['y'], 
                      :stacked => false,
                      :filename => "chart.png",
                      :size => "500x500")
                      
  # Record file in filesystem
  chart.file

