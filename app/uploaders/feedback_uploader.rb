class FeedbackUploader < ApplicationUploader

  # 2480 x 3510

  process :optimize
  process quality: 90
  process resize_to_limit: [1280, 960]

  version :image do
    process :opaque
    process convert: 'jpg'
    process quality: 80
    process resize_and_pad: [1024, 768] if :landscape?
    process watertext: I18n.t('application.name')
  end

  version :thumb do
    process :opaque
    process convert: 'jpg'
    process quality: 80
    process resize_and_pad: [320, 228], if: :landscape?
    process resize_and_pad: [320, 454, 'white'], if: !:landscape?
    process watermark: Rails.public_path.join('images', 'watermark.png')
  end

  version :icon do
    process :opaque
    process convert: 'jpg'
    process quality: 80
    process resize_and_pad: [96, 96, 'white']
  end

end
