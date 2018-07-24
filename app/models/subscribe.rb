class Subscribe < ActiveRecord::Base
  acts_as_likeable

  attr_accessible :departament, :email, :fullname, :phone_city, :phone_inter, :place, :position

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    (1..spreadsheet.last_row).each do |i|
        # unless Subscribe.where(fullname: spreadsheet.cell(i, 1)).first
        subscribe = Subscribe.new
        # subscribe.attributes = row.to_hash.slice(*accessible_attributes)
        subscribe.fullname    = spreadsheet.cell(i, 1)
        subscribe.departament = spreadsheet.cell(i, 2)
        subscribe.position    = spreadsheet.cell(i, 3)
        subscribe.place       = spreadsheet.cell(i, 4)
        subscribe.phone_inter = spreadsheet.cell(i, 5)
        subscribe.phone_city  = spreadsheet.cell(i, 6)
        subscribe.email       = spreadsheet.cell(i, 7)
        subscribe.save!
        # end
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".xlsx" then Roo::Excelx.new(file.path, file_warning: :ignore)
    else raise 'unknown file type: #{file.original_filename}'
    end
  end
end
