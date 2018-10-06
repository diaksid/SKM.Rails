module ActiveAdmin
  module Views

    class TableFor
      def column_html(attribute, *args)
        classes = []
        args.each {|item| classes += [item.delete(:class)] if item.has_key? :class}
        column(attribute, *args) do |model|
          content_tag(:div, model[attribute], {class: classes}, false) unless model[attribute].blank?
        end
      end


      def column_aimg(attribute, *args)
        href = true
        args.each {|item| href = item.delete :href if item.has_key? :href}
        size = nil
        args.each {|item| size = item.delete :size if item.has_key? :size}
        fit = false
        args.each {|item| fit = item.delete :fit if item.has_key? :fit}
        column(attribute, *args) do |model|
          render partial: 'admin/image', object: model.method(attribute).call,
                 locals: {href: href && url_for(id: model.id,
                                                action: :edit,
                                                controller: model.class.to_s.downcase.pluralize),
                          size: size,
                          fit: fit}
        end
      end

      def column_kbyte(attribute, *args)
        column(attribute, *args) do |model|
          '%.1f Kb' % (model[attribute].to_f / 1024)
        end
      end
    end

  end
end
