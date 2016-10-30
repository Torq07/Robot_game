class Robot
	
	attr_accessor :x, :y, :direction

	@@directions=%w{NORTH EAST SOUTH WEST}

	def initialize(direction,field)
		@x=nil
		@y=nil
		@field=field
		@direction=validate(direction)
	end

	def left
		@direction>0 ? @direction-=1 : @direction=@@directions.count-1
	end

	def right
		@direction<@@directions.count-1	? @direction+=1 : @direction=0
	end

	def report
		"Output:  #{self.coordinates} ,#{@@directions[@direction]} object_id:#{self.object_id}" 
	end

	def coordinates
		[@x,(@y-@field.size[1]).abs]
	end

	def set_coordinates(x,y)
		@x,@y=x,y
	end

	def move
		@field.area[@x,@y]=nil
		case @direction
		when 0 #NORTH
			@y>0 && !@field.occupied?(@x,@y-1) ? @y-=1 : puts('This cell is occupied or end of field')
		when 1 #EAST
			@x<@field.size[0] && !@field.occupied?(@x+1,@y) ? @x+=1 : puts('This cell is occupied or end of field')
		when 2 #SOUTH
			(@y<@field.size[1] && !@field.occupied?(@x,@y+1)) ? @y+=1  : puts('This cell is occupied or end of field')
		when 3 #WEST
			@x>0 && !@field.occupied?(@x-1,@y) ? @x-=1 : puts('This cell is occupied or end of field')
		end
		@field.area[@x,@y]=self
	end

	private

		def validate(direction)
			@@directions.index(direction) if @@directions.include?(direction) 
		end	

end