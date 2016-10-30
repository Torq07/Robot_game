require_relative "lib/robot.rb"
require_relative "lib/action_field.rb"

# set field dimension
class Game
	attr_reader :field

	def initialize(x=5,y=6)
		@x=x
		@y=y
		create_field
	end

	def create_field
		@field=Field.new(@x,@y)
		puts "Field is set to #{@field.x}x#{@field.y}\n\n"
		puts <<-EOF 
Now you can play with robot.Firstly you need to place a robot on field.
Use command 'place x,y,direction' to do that
EOF
	end	
	
	def place_robot(x,y,direction)
		robot=Robot.new(direction,@field)
		if robot.direction
			@field.place(robot,x,y)
		else
			"Wrong direction. Direction can accept next value: EAST,WEST,NORTH or SOUTH"  
		end  
	end

	def move
		@field.current_object.move if @field.current_object
	end

	def right
		@field.current_object.right if @field.current_object
	end
	
	def left
		@field.current_object.left if @field.current_object
	end	
	
	def report
		@field.current_object.report if @field.current_object
	end

	def take_robot
		if @field.current_object
			@field.objects.each_with_index do |obj,index|
				puts "Robot_id:#{index}, Obj_id#{obj.object_id}"
			end
			if @field.objects.first
				puts "Please enter robot_id you would like to take"
				robot_index = gets.chomp.to_i
				@field.take_object(robot_index)
			else
				puts "No robots available" 
			end	
		end	
	end

end	
