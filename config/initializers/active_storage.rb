require 'acts_as_list/active_record/acts/list'


ActiveStorage::Attachment.class_eval do
  acts_as_list column: :index,
               top_of_list: 0,
               scope: :record


  def orientation
    case
    when metadata[:width] > metadata[:height]
      1
    when metadata[:width] < metadata[:height]
      2
    else
      0
    end
  end


  def kbyte_size
    '%.1f Kb' % (byte_size.to_f / 1024)
  end
end
