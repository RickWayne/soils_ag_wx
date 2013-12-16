module GridController
  include AgwxGrids
  GRID_CLASSES = {
      'Min Temp' => WiMnDMinTAir, 'Max Temp' => WiMnDMaxTAir, 'Avg Temp' => WiMnDAveTAir,
      'Vapor Pressure' => WiMnDAveVapr, 'ET' => WiMnDet
  }
end