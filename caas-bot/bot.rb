module CaaSBot
  class Bot < SlackRubyBot::Bot

    #  @caas  =  <@SG5R79X45>
    #  @caas-bot  =  <@UK2T94ZFE>
    match /#{ENV.fetch('SLACK_MESSAGE_TRIGGER')}/ do |client, data, match|

      #don't respond in threads
      next if data.thread_ts

      client.say(
        channel: data.channel,
        text: SupportMessage.generate,
        thread_ts: data.ts
      )
    end

  end

  class SupportMessage
    def self.generate

      time = Time.now.getlocal('+02:00')
      message = if time.hour >= 9 &&
                  time.hour < 17 &&
                  time.wday >=1 &&
                  time.wday <=5
        bussiness_hours
      else
        after_hours
      end

      message += information_query

      message
    end

    def self.bussiness_hours
      "CaaS team will attend to your problem shortly."
    end

    def self.after_hours
      "We are currently out of bussiness hours. Nonprod is not supported.\n"+
      "If your issue is *urgent* and *can't wait* until morning, please create Incident for CaaS to act upon and contact them by phone call on number listed here:\n"+
      "https://confluence-agl.absa.co.za/display/CAAS/CaaS+Support+Roster"
    end

    def self.information_query
      "\n\nPlease make sure you provided following information ideally as link to your app in Openshift.\n\n"+
      "• Cluster/Environment\n"+
      "• Openshift project ID\n"+
      "• Pod ID"
    end

  end
end
