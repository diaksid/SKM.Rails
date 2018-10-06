module AdminActive
  extend ActiveSupport::Concern

  def self.included(base)
    base.send :batch_action, :active, priority: 0 do |ids|
      batch_action_collection.find(ids).each do |model|
        model.update active: true unless model.active
      end
      redirect_to collection_path, alert: t('active_admin.batch_actions.alerts.active')
    end

    base.send :batch_action, :deactive, priority: 1 do |ids|
      batch_action_collection.find(ids).each do |model|
        model.update active: false if model.active
      end
      redirect_to collection_path, alert: t('active_admin.batch_actions.alerts.deactive')
    end
  end

end
