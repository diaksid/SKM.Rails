class CustomerUploader < ApplicationUploader

  process :optimize
  process quality: 90
  process resize_to_limit: [1280, 960]

  version :thumb do
    process :opaque
    process convert: 'jpg'
    process quality: 80
    process resize_and_pad: [192, 192, 'white']
  end

  version :icon do
    process :opaque
    process convert: 'jpg'
    process quality: 80
    process resize_and_pad: [96, 96, 'white']
  end

end
