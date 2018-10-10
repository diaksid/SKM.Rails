module ImageHelper

  def resize_to(width, height = nil)
    height = width if height.nil?
    {combine_options: {
      auto_orient: true,
      gravity: 'center',
      resize: '%ix%i' % [width, height]
    }}
  end


  def resize_to_fit(width, height = nil)
    height = width if height.nil?
    {combine_options: {
      auto_orient: true,
      gravity: 'center',
      resize: '%ix%i' % [width, height],
      extent: '%ix%i' % [width, height]
    }}
  end


  def resize_to_fill(width, height = nil)
    height = width if height.nil?
    {combine_options: {
      auto_orient: true,
      gravity: 'center',
      resize: '%ix%i^' % [width, height],
      crop: '%ix%i+0+0' % [width, height]
    }}
  end


  def resize_to_area(width, height = nil)
    height = width if height.nil?
    {combine_options: {
      auto_orient: true,
      gravity: 'center',
      resize: "%i@" % (width * height)
    }}
  end


  def attachment_render_attributes(object, local)
    attrs = local[:attrs] || {}
    attrs[:class] = local[:class].nil? ? [] : [local[:class]]
    attrs[:width] ||= local[:width] || 192
    attrs[:height] ||= local[:height] || attrs[:width]
    if (attached = !object.nil?)
      # attached = object.attached? if object.is_a? ActiveStorage::Attached
      attached = object.attached? if object.methods.include? :attached?
    end
    if attached
      attrs[:class] += ['h-bg--cover']
      attrs[:class] += local[:align].nil? ? [] : ["h-bg--cover-#{local[:align]}"]
      attrs[:data] ||= {}
      unless local[:light].nil?
        attrs[:data][:light] = local[:light]
        attrs[:data][:href] = url_for(object.variant resize_to_area 800, 600)
      end
      variant = local[:fit] ? resize_to_fit(attrs[:width], attrs[:height]) :
                              resize_to_fill(attrs[:width], attrs[:height])
      if local[:lazy] === false
        attrs[:src] = url_for(object.variant variant)
      else
        attrs[:data][local[:lazy] || :lazy] = url_for(object.variant variant)
      end
    else
      attrs[:class] += ['h-bg--no-image']
    end
    local[:attached] = attached
    if local[:links]
      local[:links] = {} unless local[:links].is_a? Hash
      if local[:links][:image].nil? || local[:links][:image] == true
        local[:links][:image] = [800, 600]
      elsif local[:links][:image].is_a? Integer
        local[:links][:image] = [local[:links][:image]]
      end
      if local[:links][:thumbnail]
        local[:links][:thumbnail] = 96 unless local[:links][:thumbnail].is_a? Integer
      end
    end
    attrs
  end

end
