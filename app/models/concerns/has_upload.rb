module HasUpload
  extend ActiveSupport::Concern

  included do
  end


  def upload_recreate_versions
    done = 0
    unless upload.file.blank?
      if File.exist?(upload.file.path)
        upload.recreate_versions!
        done = 1
      else
        remove_upload!
        update! upload: nil
      end
    end
    done
  end


  module ClassMethods

    def upload_recreate_versions
      done = 0
      self.all.each { |model| done += model.upload_recreate_versions }
      done
    end

  end

end
