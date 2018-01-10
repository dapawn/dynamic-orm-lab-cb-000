require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'interactive_record.rb'
require 'pry'

class Student < InteractiveRecord
  self.column_names.each do |col_name|
    attr_accessor col_name.to_sym
  end

  def self.find_by(hash)
    hash.each do |arr|
      col_name = arr[0].to_s.sub(/:/,"")
      val = arr[1].is_a?(String) ? "'#{arr[1]}'" : arr[1]
      sql = "SELECT * FROM #{self.table_name} WHERE #{col_name} = #{val}"
      binding.pry
       DB[:conn].execute(sql)
      end
  end
end
