module Devise
  module Controllers
    module Rememberable

      def self.cookie_values
        Rails.configuration.session_options.slice(:path, :domain, :secure)
      end

      def remember_me_is_active?(resource)
        return false unless resource.respond_to?(:remember_me)
        scope = Devise::Mapping.find_scope!(resource)
        _, token, generated_at = cookies.signed[remember_key(resource, scope)]
        resource.remember_me?(token, generated_at)
      end

      # Remembers the given resource by setting up a cookie
      def remember_me(resource)
        return if request.env["devise.skip_storage"]
        scope = Devise::Mapping.find_scope!(resource)
        resource.remember_me!
        cookies.signed[remember_key(resource, scope)] = remember_cookie_values(resource)
        cookies[:token_name] = remember_key(resource, scope)
        cookies[:token_value] = remember_cookie_values(resource)
      end

      # Forgets the given resource by deleting a cookie
      def forget_me(resource)
        scope = Devise::Mapping.find_scope!(resource)
        resource.forget_me!
        cookies.delete(remember_key(resource, scope), forget_cookie_values(resource))
      end

      protected

      def forget_cookie_values(resource)
        Devise::Controllers::Rememberable.cookie_values.merge!(resource.rememberable_options)
      end

      def remember_cookie_values(resource)
        options = { httponly: true }
        options.merge!(forget_cookie_values(resource))
        options.merge!(
          value: resource.class.serialize_into_cookie(resource),
          expires: resource.remember_expires_at
        )
      end

      def remember_key(resource, scope)
        resource.rememberable_options.fetch(:key, "remember_#{scope}_token")
      end

    end
  end
end