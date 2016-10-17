class Song < ActiveRecord::Base
  acts_as_likeable

  belongs_to :album
  attr_accessible :file, :title

  has_attached_file :file,
     url: "/system/music/:album_title/:basename.:extension",
     path: ":rails_root/public/system/music/:album_title/:basename.:extension"

  Paperclip.interpolates :album_title do |attachment, style|
    url=''
    attachment.instance.album_title.each_with_index do |album, index|
      url = url + "#{index == 0 ? '' : '/'}" + album.title.parameterize
    end
    url
  end

  def album_title
    self.album.path
  end

  def clean_filename
    File.basename self.file_file_name, File.extname(self.file_file_name).downcase
  end

end
