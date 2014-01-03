require 'date'

class CalMatrix
  attr_accessor :cols
  
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
  
end