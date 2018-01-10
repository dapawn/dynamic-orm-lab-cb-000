require_relative "../config/environment.rb"
require 'active_support/inflector'
require 'interactive_record.rb'

class Student < InteractiveRecord
  self.column_names.each do |col_name|
    attr_accessor col_name.to_sym
  end

  def self.find_by(hash)
    hash.each.with_index do |key,value|
      sql = <<-SQL
        SELECT * FROM #{self.table_name} WHERE ? = ?
      SQL

      rows = DB[:conn].execute(sql, key.to_s, value)
      if rows.first
        self.reify_from_row(rows.first)
      else
        nil
      end
    end
  end
end
