class ScamReportMailer < ActionMailer::Base
    default from: "support@workcheetah.com"

    def new_scam_report(scam_report)
      @scam_report = scam_report
      mail(:to => "support@workcheetah.com", :subject => "New Scam Report")
    end

end