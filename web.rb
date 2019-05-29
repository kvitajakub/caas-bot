require 'sinatra/base'

module CaaSBot
  class Web < Sinatra::Base
    get '/' do
      'Supporting CaaS on #devsupport.'
    end
  end
end
