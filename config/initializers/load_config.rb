APP_CONFIG = YAML.load_file("#{Rails.root}/config/app_config.yml")[Rails.env]

if APP_CONFIG['mail']
  ActionMailer::Base.perform_deliveries = true
  APP_CONFIG['mail'].each do |k, v|
    v.symbolize_keys! if v.respond_to?(:symbolize_keys!)
    ActionMailer::Base.send("#{k}=", v)
  end
end
