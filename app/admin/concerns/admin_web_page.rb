module AdminWebPage
  extend ActiveSupport::Concern

  def self.included(base)
    base.send :batch_action, :published, priority: 2 do |ids|
      batch_action_collection.find(ids).each do |model|
        model.update published: true unless model.published
      end
      redirect_to collection_path, alert: t('active_admin.batch_actions.alerts.published')
    end

    base.send :batch_action, :unpublished, priority: 3 do |ids|
      batch_action_collection.find(ids).each do |model|
        model.update published: false if model.published
      end
      redirect_to collection_path, alert: t('active_admin.batch_actions.alerts.unpublished')
    end

    base.send :batch_action, :navigated, priority: 4 do |ids|
      batch_action_collection.find(ids).each do |model|
        model.update navigated: true unless model.navigated
      end
      redirect_to collection_path, alert: t('active_admin.batch_actions.alerts.navigated')
    end

    base.send :batch_action, :denavigated, priority: 5 do |ids|
      batch_action_collection.find(ids).each do |model|
        model.update navigated: false if model.navigated
      end
      redirect_to collection_path, alert: t('active_admin.batch_actions.alerts.denavigated')
    end
  end

end
