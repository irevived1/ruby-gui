require 'pry'
require 'tk'
require 'tkextlib/tile'

root = TkRoot.new {title "Vegetables"}
                      #padding around the grid, left, top, right, bottom
content = Tk::Tile::Frame.new(root) {padding "30 30 30 12"}.grid( :sticky => 'ns')
#sticky-ness text placement defaults to north east, and extends the padding when given opposing directions
#weight is the relative weight of the rows when extra space gets allocated to the layout
TkGrid.columnconfigure root, 0, :weight => 1
TkGrid.rowconfigure root, 0, :weight => 1

#adding children to the content/frame
Tk::Tile::Label.new(content) {text 'Tomato' }.grid( :column => 1, :row => 1 ) #can be sticky 
Tk::Tile::Label.new(content) {text 'Parsley'}.grid( :column => 1, :row => 2 )
Tk::Tile::Label.new(content) {text 'Onion'}.grid( :column => 2, :row => 1  )
Tk::Tile::Label.new(content) {text 'Lettuce'}.grid( :column => 2, :row => 2  )


$feet = TkVariable.new; $meters = TkVariable.new
f = Tk::Tile::Entry.new(content) {width 7; textvariable $feet}.grid( :column => 2, :row => 1, :sticky => 'we' )
Tk::Tile::Label.new(content) {textvariable $meters}.grid( :column => 2, :row => 2, :sticky => 'we');
Tk::Tile::Button.new(content) {text 'Calculate'; command {calculate}}.grid( :column => 3, :row => 3, :sticky => 'w')
f.focus
root.bind("Return") {calculate}

def calculate
	begin
		$meters.value = (0.3048*$feet*10000.0).round()/10000.0
	rescue
		$meters.value = ''
	end
end
#adding padding to each child/tile
TkWinfo.children(content).each {|w| TkGrid.configure w, :padx => 50, :pady => 50}

Tk.mainloop
