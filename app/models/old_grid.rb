class OldGrid < ActiveRecord::Base
  def self.connect(old_table_name)
    establish_connection adapter: 'mysql',
      host: '127.0.0.1',
      username: 'wayne',
      password: 'agem.Data',
      database: 'aws'
    self.table_name = old_table_name
  end
end