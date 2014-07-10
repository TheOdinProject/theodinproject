namespace :email do
  
  desc "send email via SendGrid API"
  task :send, [:mailer, :message, :recipient] => [:environment, :get_smtpapi_header] do | t, args |
    mailer = Kernel.const_get(args[:mailer].classify)
    puts SMTPAPI
    mailer.send(args[:message], SMTPAPI).deliver
  end

  desc "build smptapi header" 
  task :get_smtpapi_header, [:recipient] => :environment do | t, args |
    SMTPAPI = {
      "to" => [
        args[:recipient]
      ]
    }.to_json
  end

end
