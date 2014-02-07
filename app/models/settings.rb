class Settings < Settingslogic
  source "./config/application.yml"
  namespace Rails.env
end
