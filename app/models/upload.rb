class Upload < ActiveRecord::Base
  attr_accessible :filename
  mount_uploader :filename, PicUploader

  has_many :media, 	:class_name => "Media", :foreign_key => "fkfile"
  has_many :mod, 		:through => :media

  before_save :update_filename_attributes
  
  private
  
  def update_filename_attributes
    if filename.present? && filename_changed?
      self.ext = filename.file.content_type
      self.file_size = filename.file.size
    end
  end
end
