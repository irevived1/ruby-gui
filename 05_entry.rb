require 'tk'
require 'tkextlib/tile'

root = TkRoot.new {title "Vegetables"}
#padding around the grid, left, top, right, bottom
#sticky-ness text placement defaults to north east, and extends the padding when given opposing directions
content = Tk::Tile::Frame.new(root) {padding "30 30 30 12"}.grid( :sticky => 'ns')

#weight is the relative weight of the rows when extra space gets allocated to the layout
TkGrid.columnconfigure root, 0, :weight => 1
TkGrid.rowconfigure root, 0, :weight => 1

#adding children to the content/frame
Tk::Tile::Label.new(content) {text 'Tomato' }.grid( :column => 1, :row => 1, sticky:'w' ) #can be sticky 
Tk::Tile::Label.new(content) {text 'Parsley'}.grid( :column => 1, :row => 2, sticky:'w')
Tk::Tile::Label.new(content) {text 'Onion'}.grid( :column => 2, :row => 1  )
Tk::Tile::Label.new(content) {text 'Lettuce'}.grid( :column => 2, :row => 2  )

$input = TkVariable.new; $display = TkVariable.new
entry = Tk::Tile::Entry.new(content) {width 12; textvariable $input}.grid( :column => 1, :row => 3 )#, :sticky => 'we' )
Tk::Tile::Button.new(content) {text 'Shout!'; command {shout!}}.grid( :column => 2, :row => 3)#, :sticky => 'w')
Tk::Tile::Label.new(content) {text 'psst... '}.grid( :column => 1, :row => 4, :sticky => 'e')
Tk::Tile::Label.new(content) {textvariable $display}.grid( :column => 2, :row => 4, :sticky => 'w');

#adding padding to each child/tile
TkWinfo.children(content).each {|w| TkGrid.configure w, :padx => 10, :pady => 25}

#focuses on entry
entry.focus
root.bind("Return") {shout!}

def shout!
	begin
    $display.value = $input.to_s.upcase + " !!"
	rescue
		$display.value = ''
	end
end

Tk.mainloop
