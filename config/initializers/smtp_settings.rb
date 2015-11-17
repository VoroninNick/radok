class Settings
    def self.[](arg)
        config = YAML.load_file(File.open(Rails.root.join("config/settings/development.yml")))
        path_fragments = arg.split(".")
        res = config

        path_fragments.each do |f|
            res = res[f]
            if res.nil?
                return nil
            end
        end

        return res
    end
end

smtp_profile = :yandex

ActionMailer::Base.default_url_options = { host: Settings['mailer.host'], only_path: false }

# gmail config
if smtp_profile == :gmail
    ActionMailer::Base.smtp_settings = {
        :address              => Settings["mailer.gmail.address"],
        :port                 => Settings["mailer.gmail.port"], # 587
        :domain               => Settings["mailer.gmail.domain"],
        :user_name            => Settings["mailer.gmail.email"],
        :password             => Settings["mailer.gmail.password"],
        :authentication       => Settings["mailer.yandex.authentication"],
        :enable_starttls_auto => true # default: true
    }

end


if smtp_profile == :yandex


    ActionMailer::Base.smtp_settings = {
        address: Settings["mailer.yandex.address"],
        domain:  Settings["mailer.yandex.domain"],
        port:    Settings["mailer.yandex.port"],

        user_name: Settings["mailer.yandex.email"],
        password:  Settings["mailer.yandex.password"],

        authentication: Settings["mailer.yandex.authentication"],
        enable_starttls_auto: true
    }
end