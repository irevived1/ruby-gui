require 'tk'
require 'tkextlib/tile'

root = TkRoot.new {title "Vegetables"}
                      #padding around the grid, left, top, right, bottom
content = Tk::Tile::Frame.new(root) {padding "30 30 30 12"}.grid( :sticky => 'ns')
#sticky-ness text placement defaults to north east, and extends the padding when given opposing directions
TkGrid.columnconfigure root, 0, :weight => 1
TkGrid.rowconfigure root, 0, :weight => 1
TkGrid.rowconfigure root, 1, :weight => 5

Tk::Tile::Style.configure('Label', {'activeborderwidth' => 2})

Tk::Tile::Label.new(content) {text 'Tomato' }.grid( :column => 1, :row => 1 ) #, :sticky => 'n');

Tk::Tile::Label.new(content) {text 'Parsley'}.grid( :column => 1, :row => 2  ) #,:sticky => 'w')
Tk::Tile::Label.new(content) {text 'Onion'}.grid( :column => 2, :row => 1  ) #,:row => 2, :sticky => 'e')
Tk::Tile::Label.new(content) {text 'Lettuce'}.grid( :column => 2, :row => 2  ) #,:sticky => 'w')

TkWinfo.children(content).each {|w| TkGrid.configure w, :padx => 5, :pady => 5}

Tk.mainloop
