require 'app_settings'
class AppSettings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env

  def env_title
    self.title << " " << Rails.env
  end
end
