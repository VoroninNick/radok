require_relative 'settings'

smtp_profile = :yandex

ActionMailer::Base.default_url_options = { host: ENV['mailer.host'], only_path: false }

# gmail config
if smtp_profile == :gmail
    ActionMailer::Base.smtp_settings = {
        :address              => ENV["mailer.gmail.address"],
        :port                 => ENV["mailer.gmail.port"], # 587
        :domain               => ENV["mailer.gmail.domain"],
        :user_name            => ENV["mailer.gmail.email"],
        :password             => ENV["mailer.gmail.password"],
        :authentication       => ENV["mailer.yandex.authentication"],
        :enable_starttls_auto => true # default: true
    }

end


if smtp_profile == :yandex


    ActionMailer::Base.smtp_settings = {
        address: ENV["mailer.yandex.address"],
        domain:  ENV["mailer.yandex.domain"],
        port:    ENV["mailer.yandex.port"],

        user_name: ENV["mailer.yandex.email"],
        password:  ENV["mailer.yandex.password"],

        authentication: ENV["mailer.yandex.authentication"],
        enable_starttls_auto: true
    }
end