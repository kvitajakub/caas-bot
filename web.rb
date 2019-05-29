require 'sinatra/base'

module SlackMathbot
  class Web < Sinatra::Base
    before do
      logger.level = 0
    end
    get '/' do
      'Math is good for you.'
    end
  end
end
