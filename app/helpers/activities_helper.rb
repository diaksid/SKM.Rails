module ActivitiesHelper

  def activities_navigation
    Activity.roots.navigated.collect { |model| activity_navigation model }.join.html_safe
  end


  def activity_navigation(model)
    html = content_tag :a, "#{'&nbsp;' * 3 * model.ancestry_depth}#{model.name}".html_safe,
                       href: activity_path(model),
                       class: ['mdl-navigation__link', activity_link_status(model)].reject(&:blank?).join(' ')
    if model.has_children?
      html += content_tag :div, class:'c-navigation__submenu' do
        model.children.navigated.collect { |child| activity_navigation child }.join.html_safe
      end
    end
    html.html_safe
  end


  def activity_link_status(model)
    if @model && @model.instance_of?(Activity)
      if model ==  @model
        'is-active'
      elsif model.descendants.exists? @model.id
        'is-parent'
      end
    end
  end

end
