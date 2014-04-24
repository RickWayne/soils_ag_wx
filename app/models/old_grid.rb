class OldGrid < ActiveRecord::Base
  def self.connect(old_table_name)
    establish_connection adapter: 'mysql',
      host: '127.0.0.1',
      username: 'wayne',
      password: 'agem.Data',
      database: 'grids'
    self.table_name = old_table_name
  end

  def self.translate(old_table_name,new_class)
    connect(old_table_name)
    (first.date.year..2013).each do |year|
      puts year
      ii=0
      where('date >= ? and date <= ?',Date.civil(year,1,1),Date.civil(year,12,31)).each do |rec|
        attr_hash = {}
        rec.attributes.each do |key,val|
          if key =~ /([\d]{3})w/
            attr_hash["w#{$1}"] = val
          else
            attr_hash[key]=val if key
          end
        end
        new_class.create! attr_hash
        ii+=1
        print "."; $stdout.flush if (ii > 100 && ii%100 == 0)
      end
    end
  end
end