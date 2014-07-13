class AppSettings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env

  def env_title
    @title ||= if Rails.env.production?
                 self.title
               else
                 self.title << " " << Rails.env
               end
  end
end

