ActiveAdmin.register_page 'Dashboard' do
  menu priority: 0, label: proc { I18n.t 'active_admin.dashboard' }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content

  sidebar 'Аккаунт' do
    h3 class: 'h-margin-top--1' do
      link_to(current_user, admin_user_path(current_user))
    end
    attributes_table_for current_user do
      row :is_admin
      row :sign_in_count
      row :current_sign_in_at do
        time_ago_in_words current_user.current_sign_in_at
      end
      row :current_sign_in_ip
    end
    attributes_table_for current_user do
      row :customers do |model|
        link_to model.customers.count, admin_customers_path('q[user_id_eq]' => model)
      end
    end
  end
end
