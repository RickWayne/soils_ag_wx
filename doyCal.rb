#!/usr/local/bin/ruby

require 'date'

class CalMatrix
  @cols
  
  # default to making a calendar for this year
  def initialize(aDate = Date.today)
    year = aDate.year
    mon = aDate.mon
    aDate = Date.new(year,1,1)
    @cols = Array.new
    while (year == aDate.year)
      # do one column
      col = Array.new
      @cols[mon-1] = col
      while (mon == aDate.mon)
        col[aDate.mday-1] = aDate.yday.to_s
        aDate = aDate.succ
      end
      mon = aDate.mon
    end
  end
  
  def col(index)
    @cols[index]
  end
  
  def row(mday)
    aRow = Array.new
    0.upto 11 do |colIndex|
      aCol = col(colIndex)
      if (mday - 1 < aCol.size)
        aRow[colIndex] = aCol[mday-1]
      end
      colIndex += 1
    end
    aRow
  end
  
  def row_to_s(mday)
    aRow = row(mday)
    aRowStr = Array.new
    if (aRow != nil)
      aRowIndex = 0
      aRow.each do |doy|
        aRowStr[aRowIndex] = doy.to_s
        aRowIndex += 1
      end
    else
      print("row_to_s: row nil!\n")
    end
    aRowStr
  end
  
end # CalMatrix


  
print("<html><body><table border=\"1\">\n")
months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
0.upto 11 do |mon|
  print("<th>#{months[mon]}</th>")
end
print("\n")

if (ARGV[0] != nil)
  year = ARGV[0].to_i
  aDate=Date.new(year,1,1)
else
  aDate=Date.today
end
cal2 = CalMatrix.new(aDate)
1.upto 31 do |mday|
  print("<tr>")
  aRowStr = cal2.row_to_s(mday)
  first = true
  aRowStr.each do |doy|
    if (first)
      print("<td><strong>#{doy}</strong></td>")
      first=false
    else
      print("<td>#{doy}</td>")
    end
  end
  print("</tr>\n")
end
0.upto 11 do |mon|
  print("<th>#{months[mon]}</th>")
end
print("\n")
print("</table></body></html>\n")
