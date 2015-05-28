# glossika2anki

solution:  
  
convert pdf pages to png with ghostscript. could probably use a gem  
erase the images at the beginning of lines for better OCR  
use gimp and grids to determine good height for rows  
chop image into rows, ignore rows without text, add a bit of blur, OCR each row and remove newlines  
save to file  
lots of text processing voodoo in vim to create a perfect delimited file for import  
could probably do this in the script. maybe later  
  
then use mp3splt to chop audio. delete filler. if there aren't exactly 2000 files, adjust -p shots  
move to collections.media folder  
winning  
