require './game.rb'


describe 'Robot game' do
	
	before(:each) do
		@x=rand(15)
		@y=rand(15)
    @game = Game.new(@x,@y)
  end

  it "should ignore all commands before first 'PLACE' command" do
  	methods=%w{move left right report take_robot}
  	methods.each do |method|
  		expect(@game.send(method.to_sym)).to be nil
  	end
  end

  it "should create a game with specific coordinate" do
    expect(@game).to be_instance_of(Game)
    expect(@game.field.size).to eq([@x,@y])
  end

  it "shouldn't place the robot out of field" do
  	result=@game.place_robot(10,10,'EAST')
  	expect(result).to eq('Sorry this cell is occupied or out of field')
  end

  it "shouldn't place the robot with wrong direction" do
  	result=@game.place_robot(10,10,'SUOTH')
  	expect(result).to match /Wrong direction/
  end

  it "robot shouldn't fall from the field." do
  	# 0,0 is SOUTH-WEST so any move to SOUTH or WEST 
  	# will lead to fall the robot off the table
  	@game.place_robot(0,0,'WEST') 
  	result=@game.move.coordinates
  	expect(result).to eq([0,0])
  end

  it "Report command should show up coordinates and direction" do
  	f=%w{WEST EAST NORTH SOUTH}
  	@game.place_robot(rand(@game.field.x-1),rand(@game.field.y-1),f.sample) 
  	result=@game.report
  	expect(result).to match /Output:(\W+)\[\d+\W+\d+\]\W+(WEST|EAST|NORTH|SOUTH)\W+object_id:\d+/
  end

end