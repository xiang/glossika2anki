#!/usr/bin/env ruby
require 'rmagick'
require 'rtesseract'
include Magick

source='../ENES-F1-EBK.pdf'
first = 373
last = 373
lang = "eng+spa"

lines = []

(first..last).each do |n|

  # starting offset
  x = 330
  y = 300
  width = 1400
  height = 180

  system("gs -dBATCH -dNOPAUSE -dFirstPage=#{n} -dLastPage=#{n} -sDEVICE=pnggray -r300x300 -sOutputFile=page.png -f '#{source}'")

  png = ImageList.new("./page.png")

  1.times do 
    4.times do |i|
      if i < 2
#        snippet.display
        snippet = png.crop(x, y, width, height).adaptive_blur
        snippet.write("tmp.png")
        text = RTesseract.new("./tmp.png", :lang => lang, :psm => 6)
        text.to_s.gsub!("\n\n","").gsub!("\n"," ")
        lines << text
      end
      y += height
    end
  end
end

File.open('lines.txt', 'w+') { |f| f.puts lines }
