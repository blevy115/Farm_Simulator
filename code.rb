

class Farm

  def initialize(name)
    @name = name
    @all_fields = []
    @total_harvest = 0
  end

  def main_menu
    while true
    print_main_menu
    user_selection = gets.chomp
    call_option(user_selection)
    end
  end

  def print_main_menu
    puts "--------------------"
    puts "Options"
    puts "field -> adds a new field"
    puts "harvest -> harvests crops and adds to total harvested"
    puts "status -> displays some information about the farm"
    puts "relax -> provides lovely descriptions of your fields"
    puts "exit -> exits the program"
    puts "--------------------"
  end

  def call_option(user_selection)
    case user_selection
    when "field" then add_new_field
    when "harvest" then harvest_crops
    when "status" then status
    when "relax" then relax
    when "exit" then quit
    else  puts "Not a valid command, please try again"
    end
  end

  def status
    @all_fields.each do |field|
    puts "#{field.type} field is #{field.area} hectares."
    end
    puts "The farm has #{@total_harvest} harvested food so far."
  end

  def harvest_crops
    @all_fields.each do |field|
      puts "Harvesting #{field.harvest} food from #{field.area} hectare #{field.type} field."
      @total_harvest += field.harvest
      field.area=(0)
    end
    puts "The farm has #{@total_harvest} harvested food so far."
  end

  def add_new_field
    puts "What kind of field is it: corn or wheat?"
    type = gets.chomp
    until Field.types_of_fields.include?(type)
      puts "Please enter a valid field type"
      type = gets.chomp
    end
    puts "How large is the field in hectares?"
    area = gets.chomp.to_i
    until area != 0
      puts "please enter a valid area"
      area = gets.chomp.to_i
    end
    if type == "corn"
      @all_fields << Corn.new(area)
    elsif type == "wheat"
      @all_fields << Wheat.new(area)
    end
    puts "Added a #{type} field of #{area} hectares!"
  end

  def relax
    print "You relax to the sight of "
     @all_fields.each do |field|
    print "#{field.area} hectares of #{field.type}, "
    end
    print "it's nice to sit back once in a while."
    puts ""
  end

  def quit
    puts "Exiting..."
    abort
  end

  def total_harvest
    @total_harvest
  end
end


class Field
@@types_of_fields = ["corn", "wheat"]
  def initialize(type, area)
    @type = type
    @area = area
  end

  def type
    @type
  end

  def area
    @area
  end

  def area=(area)
    @area = area
  end

  def self.types_of_fields
    @@types_of_fields
  end
end

class Corn < Field
  @@harvest_factor = 20

  def initialize(area)
    @type = "corn"
    @area = area
  end

  def harvest
    harvest = @@harvest_factor*area
  end

end

class Wheat < Field
  @@harvest_factor = 30

  def initialize(area)
    @type = "wheat"
    @area = area
  end

  def harvest
    harvest = @@harvest_factor*area
  end

end

farm = Farm.new("My Farm")
farm.main_menu
