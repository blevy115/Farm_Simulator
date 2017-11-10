

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
      if field.class != Pasture
      if field.area != 0
    puts "#{field.type} field is #{field.area} hectares."
  end
elsif field.class == Pasture
  field.all_animals.each do |animal, amount|
    if amount > 1
      puts "There are #{amount} #{animal} on the Pasture"
    elsif amount == 1
      puts "There is #{amount} #{animal} on the Pasture"
    end 
  end

  end
    end
    puts "The farm has #{@total_harvest} harvested food so far."
  end

  def harvest_crops
    @all_fields.each do |field|
      if field.class != Pasture
        if field.area != 0
      puts "Harvesting #{field.harvest} food from #{field.area} hectare #{field.type} field."
      @total_harvest += field.harvest
      field.area=(0)
    end
    elsif field.class == Pasture
       field.harvest
    end
    end
    puts "The farm has #{@total_harvest} harvested food so far."
  end

  def add_new_field
    puts "What kind of field is it: corn or wheat, tomatoes or pasture?"
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
    elsif type == "tomatoes"
      @all_fields << Tomato.new(area)
    elsif type == "pasture"
      @all_fields << Pasture.new(area)
    end
    puts "Added a #{type} field of #{area} hectares!"
  end

  def relax
    print "You relax to the sight of "
     @all_fields.each do |field|
       if field.area != 0
    print "#{field.area} hectares of #{field.type}, "
  end
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
@@types_of_fields = ["corn", "wheat", "tomatoes", "pasture"]
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

class Tomato < Field
  @@harvest_factor = 10

  def initialize(area)
    @type = "tomatoes"
    @area = area
  end

  def harvest
    harvest = @@harvest_factor*area
  end

end

class Pasture < Field

  def initialize(area)
    @all_animals = {}
    @type = "pasture"
    @area = area
    puts "How many animals on the pasture?"
    number_of_animals = gets.chomp.to_i
    until number_of_animals <= area/10
      puts "Not enough area for the animals"
      puts "How many animals on the pasture?"
      number_of_animals = gets.chomp.to_i
    end
    i = 0
    until i == number_of_animals
      puts "What type of animal is on this pasture?"
      animal_type = gets.chomp
      if @all_animals.key?(animal_type) == false
      @all_animals[animal_type] = 1
      else
        @all_animals[animal_type] += 1
      end
      i+=1
    end
  end

  def harvest
      @all_animals.each do |type, number|
        if @all_animals[type] >= 2
          @all_animals[type] *=2
          puts "The #{type} have bred and there are now twice as many."
        end
        if @all_animals[type] > 1
        puts "There are now #{@all_animals[type]} #{type} in the pasture."
      elsif @all_animals[type] = 1
        puts "There is #{@all_animals[type]} #{type} in the pasture."
      end
      end
  end

  def all_animals
    @all_animals
  end
end



farm = Farm.new("My Farm")
farm.main_menu
