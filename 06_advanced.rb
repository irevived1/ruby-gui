
require 'unirest'
require 'tk'
require 'tkextlib/tile'

root = TkRoot.new {title "Advanced Input"}
#padding around the grid, left, top, right, bottom
#sticky-ness text placement defaults to north east, and extends the padding when given opposing directions
content = Tk::Tile::Frame.new(root) {padding "30 30 30 12"}.grid( :sticky => 'ns')
#log = TkText.new(root) {state 'disabled';width 80;height 14;wrap 'none'}.grid

#weight is the relative weight of the rows when extra space gets allocated to the layout
TkGrid.columnconfigure root, 0, :weight => 1
TkGrid.rowconfigure root, 0, :weight => 1

#adding children to the content/frame
$input = TkVariable.new; $display = TkVariable.new
entry = Tk::Tile::Entry.new(content) {width 50; textvariable $input}.grid( :row => 1 )
Tk::Tile::Button.new(content) {text 'Submit'; command {function}}.grid( :row => 2 )
Tk::Tile::Label.new(content) {textvariable $display}.grid( :row => 3 )

#adding padding to each child/tile
TkWinfo.children(content).each {|w| TkGrid.configure w, :padx => 5, :pady => 25}

#focuses on entry
entry.focus
root.bind("Return") {function}

def function
	begin
    response = Unirest.get "https://yoda.p.mashape.com/yoda?sentence=#{URI.escape($input.to_s.split(/\s+/).join("+"))}",
  headers:{
    "X-Mashape-Key" => "E8TI2pOWFwmshk02Wjif3Hu91xDGp1F5TZIjsniy4SUhEzkTUy",
    "Accept" => "text/plain"
  }
    $display.value = response.body  
	rescue
		$display.value = ''
	end
end

Tk.mainloop
