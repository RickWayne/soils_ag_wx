# 31 21 366
# -98.000000 -86.000000
# 42.000000 50.000000
# 1 366 1
# -9999.000000 2

LAT_DIM = 21
LONG_DIM = 31
# <!-- X: 34 to 512 Y: 181 to 616 -->

X_LEFT = 34
X_RIGHT = 562

Y_UPPER=181
Y_LOWER=616

CELL_X = (X_RIGHT - X_LEFT) / (LONG_DIM - 1)
CELL_Y = (Y_LOWER - Y_UPPER) / (LAT_DIM - 1)

LONG_LEFT = -98.0
LONG_RIGHT = -86.0
LAT_UPPER = 50.0
LAT_LOWER = 42.0
CELL_LONG = (LONG_RIGHT - LONG_LEFT) / (LONG_DIM - 1)
CELL_LAT = (LAT_UPPER - LAT_LOWER) / (LAT_DIM - 1)
puts %Q{<map name="latlong" id="latlong">}
y =Y_UPPER
LAT_UPPER.step(LAT_LOWER,-1 * CELL_LAT) do |latitude|
  x = X_LEFT
  LONG_LEFT.step(LONG_RIGHT,CELL_LONG) do |longitude|
    puts %Q{<area shape="rect" coords="#{x},#{y},#{x+CELL_X-1},#{y+CELL_Y-1}" onclick="return regionMap(#{latitude},#{longitude})"/>}
    x += CELL_X
  end
  y += CELL_Y
end
puts "</map>"