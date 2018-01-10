require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'interactive_record.rb'
require 'pry'

class Student < InteractiveRecord
  self.column_names.each do |col_name|
    attr_accessor col_name.to_sym
  end

  def self.find_by(hash)
    col_name = hash[0][0].to_s.sub(/:/,"")
    val = hash[0][1].is_a?(String) ? "'#{hash[0][1]}'" : hash[0][1]
    sql = "SELECT * FROM #{self.table_name} WHERE #{col_name} = #{val}"
    binding.pry
    DB[:conn].execute(sql)
  end
end
