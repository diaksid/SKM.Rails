module ActiveAdmin

  class UserAdapter < ActiveAdmin::AuthorizationAdapter
    def authorized?(action, subject = nil)
      if user.admin?
        true
      elsif user.staff?
        case subject
          when normalized(User)
            if action == :read || action == :update
              subject == user
            else
              true
            end
          else
            true
        end
      end
    end
  end

end
