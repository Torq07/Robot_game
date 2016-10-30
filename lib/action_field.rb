
class Field
	
	require 'matrix'

	class Matrix < Matrix
	  def []=(row, column, value)
	    @rows[row][column] = value
	  end
	end
	
	attr_reader :x, :y, :field, :objects, :current_object
	attr_accessor :area

	def initialize(x,y)
		@x=x
		@y=y
		@area=Matrix.build(x, y){nil}
		@objects=[]
		@current_object=nil
	end

	def occupied?(x,y)
		true if @area[x,y]
	end

	def set_current_object(obj)
		@current_object=obj
	end

	def place(obj,x,y)
		if (x>@x-1 || y>@y-1) || occupied?(x,y)
			return "Sorry this cell is occupied or out of field"	
		else
			obj.set_coordinates(x,(y-@y).abs)
			@area[x,(y-@y).abs]=obj
			@objects<<obj
			set_current_object(obj)
			return "Robot placed" 
		end
	end

	def size
		[@x,@y]
	end

	def take_object(index)
		set_current_object @objects[index]
		puts "You take obj: #{self.object_id}"
	end

end


