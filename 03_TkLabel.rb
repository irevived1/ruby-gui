require 'tk'
root = TkRoot.new { title "Bok Choy" }
TkLabel.new(root) do
  text 'I am a vegetable'
  #right and bottom
  pack('padx'=>10, 'pady'=>10, 'side'=>'right')
end
Tk.mainloop
