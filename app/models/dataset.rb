class Dataset < ApplicationRecord
  belongs_to :user
  belongs_to :folder

  has_attached_file :src,
      url: "/system/files/:user_id/:folder_id/:basename.:extension",
      path: ":rails_root/public/system/files/:user_id/:folder_id/:basename.:extension"

  validates :src, attachment_presence: true
  validate :check_uniq_title, on: :create
  do_not_validate_attachment_file_type :src

  Paperclip.interpolates :folder_id do |attachment, style|
    attachment.instance.folder_id
  end

  Paperclip.interpolates :user_id do |attachment, style|
    attachment.instance.user_id
  end

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
             'name' => read_attribute(:src_file_name),
             'size' => read_attribute(:src_file_size),
              'url' => upload.url(:original),
       'delete_url' => upload_path(self),
      'delete_type' => 'DELETE'
    }
  end

  private

  def check_uniq_title
    errors.add(:src, I18n.t('dataset.already_exist_in_folder')) if self.folder.datasets.pluck(:src_file_name).include? self.src_file_name
  end
end
