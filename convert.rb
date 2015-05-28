#!/usr/bin/env ruby
require 'rmagick'
require 'rtesseract'
include Magick

source='./GLOSSIKA-ENPB-F1-EBK/ENPB-F1-EBK.pdf'
first = 42
last = 291
lang = "eng+por"

lines = []

(first..last).each do |n|

  # starting offset
  x = 170
  y = 140
  width = 1400
  height = 140

  system("gs -dBATCH -dNOPAUSE -dFirstPage=#{n} -dLastPage=#{n} -sDEVICE=pnggray -r300x300 -sOutputFile=page.png -f '#{source}'")

  png = ImageList.new("./page.png")

  # get rid of images
  gc = Draw.new
  gc.stroke = "white"
  gc.fill = "white"
  rtop = n % 2 == 0 ? 260 : 300
  rbottom = n % 2 == 0 ? 350 : 390
  gc.rectangle(rtop,0,rbottom,2200)
  gc.draw(png)
  
  4.times do 
    4.times do |i|
      snippet = png.crop(x, y, width, height).adaptive_blur
      snippet.write("tmp.png")
      if i < 2
        #snippet.display
        text = RTesseract.new("./tmp.png", :lang => lang, :psm => 6)
        text.to_s.gsub!("\n\n","").gsub!("\n"," ")
        lines << text
      end
      y += height
    end
  end
end

File.open('lines.txt', 'w+') { |f| f.puts lines }
