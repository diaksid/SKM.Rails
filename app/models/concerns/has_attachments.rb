module HasAttachments
  extend ActiveSupport::Concern

  included do
    has_many_attached :attaches
    accepts_nested_attributes_for :attaches_attachments,
                                  allow_destroy: true
    attr_accessor :attaches_purge
    after_save :attaches_check
    private_class_method :attaches_check
  end


  def attach
    @attach ||= Attach.new attaches
  end


  protected


  class Attach
    def initialize(attaches)
      @attaches = attaches
      @first = attaches.attached? ? attaches.order(:index).first : nil
    end

    def attached?
      @attaches.attached?
    end

    def variant(*size)
      @first&.variant(*size)
    end

    def metadata
      @first&.metadata
    end

    def kbyte_size
      '%.1f Kb' % (@first&.byte_size.to_f / 1024)
    end
  end


  def attaches_check
    attaches.each do |item|
      if item.byte_size > 1048576
        item.purge
        errors[:base] << I18n.t('errors.messages.file_too_big')
      end
    end
  end


  module ClassMethods

    def attaches_check
      self.all.each(&:attaches_check)
    end

  end

end
