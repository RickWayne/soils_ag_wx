module GridController
  include AgwxGrids
  GRID_CLASSES = {
      'Min Temp' => WiMnDMinTAir, 'Max Temp' => WiMnDMaxTAir, 'Avg Temp' => WiMnDAveTAir,
      'Vapor Pressure' => WiMnDAveVapr, 'ET' => WiMnDet
  }

  def to_csv(data,param_name)
    CSV.generate do |csv|
      csv << ["Date",param_name]
      data.keys.sort.each do |date|
        csv << [date,data[date]]
      end
    end
  end
  
end