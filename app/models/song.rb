class Song < ActiveRecord::Base
  acts_as_likeable

  belongs_to :album

  has_attached_file :file, validate_media_type: false,
     url: "/system/music/:album_title/:basename.:extension",
     path: ":rails_root/public/system/music/:album_title/:basename.:extension"

  validates_attachment :file, presence: true
  do_not_validate_attachment_file_type :file

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
