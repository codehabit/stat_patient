class AppSettings < Settingslogic
  source "#{Rails.root}/config/application.yml"
  namespace Rails.env

  def env_title
    @title ||= self.title << " " << Rails.env
  end
end

