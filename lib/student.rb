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
      binding.pry
      sql = <<-SQL
        SELECT * FROM #{self.table_name} WHERE ? = ?
      SQL

      rows = DB[:conn].execute(sql, arr[0].to_s.sub(/:/,""), arr[1])
      if rows.first
        self.reify_from_row(rows.first)
      else
        nil
      end
    end
  end
end
