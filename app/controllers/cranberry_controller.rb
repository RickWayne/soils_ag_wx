class CranberryController < ApplicationController
  before_filter :set_title
  
  def index
  end
  
  def summary
    unless params[:latitude] && params[:longitude]
      redirect_to :index
      return
    end
    @latitude = params[:latitude].to_f
    @longitude = params[:longitude].to_f
    start_date = Date.new(Date.today.year,4,1)
    finish_date = Date.today - 1
    begin
      @sums = Product.find_by_name('Wisconsin-Minnesota Cranberry ET').monthly_sums(@latitude,@longitude,start_date,finish_date)
      if params[:ajax]
        render :partial => 'summary', :layout => false
      end
    rescue ActiveRecord::StatementInvalid => e
      @errMesg = 'Coordinates outside our data zone; please try a point closer to the center of the map'
      if params[:ajax]
        render :partial => 'summary', :layout => false
      end
    end
  end
  
  private
  def set_title
    @title = "Cranberry Consumptive Use Estimates"
  end
end
