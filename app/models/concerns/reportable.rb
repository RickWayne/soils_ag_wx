module Reportable
  # Using http://stackoverflow.com/questions/10692961/inheriting-class-methods-from-mixins
  # Since I want to mix in both class and instance methods with one module
  def self.included base
    base.send :include, InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def to_csv(attrs_to_show=nil)
      attrs_to_show ||= self.class.attr_human_readables
      puts "to_csv: "+self.inspect; $stdout.flush
      CSV.generate_line(attrs_to_show.collect { |pair| send(pair[0]) })
    end
  end

  module ClassMethods
    def csv_header(attrs_to_show=nil)
      attrs_to_show ||= attr_human_readables
      CSV.generate_line(attrs_to_show.collect { |atr| atr[1] })
    end
    def attrs_canonical_order
      attr_human_readables.collect { |ahr| ahr[0] }
    end
    def human_readables
      attr_human_readables.collect { |ahr| ahr[1] }
    end
  end  
end