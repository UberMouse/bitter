require 'sinatra/base'
module Sinatra
  module Auth
    module Helpers
      def authorized?
        session['id'].present?
      end

      def authorize!
        redirect '/' unless authorized?
      end

      def logout
        session['id'] = nil
      end
    end

    def self.registered(app)
      app.helpers Auth::Helpers

      app.before do
        if session['id'].present?
          unless User.exists? id: session['id']
            session['id'] = nil
            return
          end
          @user = User.find(session['id'])
        end
      end
    end
  end

  register Auth
end