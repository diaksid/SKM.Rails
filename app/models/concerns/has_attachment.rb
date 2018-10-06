module HasAttachment
  extend ActiveSupport::Concern

  included do
    has_one_attached :attach
    attr_accessor :attach_purge
    after_save :attach_check
    private_class_method :attach_check
  end


  protected


  class Attach
    def initialize(attach)
      @attach = attach
    end

    def attached?
      @attach.attached?
    end

    def variant(*size)
      @attach.variant(*size)
    end

    def kbyte_size
      '%.1f Kb' % (@attach.byte_size.to_f / 1024)
    end
  end


  def attach_check
    if attach.attached?
      if attach.byte_size > 1048576
        attach.purge
        errors[:base] << I18n.t('errors.messages.file_too_big')
      end
    end
  end


  module ClassMethods

    def attach_check
      self.all.each(&:attach_check)
    end

  end

end
