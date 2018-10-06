class ArticleUploader < ApplicationUploader

  process :optimize
  process quality: 90
  process resize_to_limit: [1280, 960]

  version :image do
    process :opaque
    process convert: 'jpg'
    process quality: 80
    process resize_to_limit: [1024, 768]
    process watertext: I18n.t('application.name')
  end

  version :thumb do
    process :opaque
    process convert: 'jpg'
    process quality: 80
    process resize_to_fill: [320, 240], if: :cropping?
    process resize_and_pad: [320, 240, 'white'], if: !:cropping?
    process watermark: Rails.public_path.join('images', 'watermark.png')
  end

  version :icon do
    process :opaque
    process convert: 'jpg'
    process quality: 80
    process resize_and_pad: [96, 96, 'white']
  end

end
