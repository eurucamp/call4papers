# Chillout

## Installation

Add this line to your application's Gemfile:

    gem 'chillout'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chillout

## Chill out with Ruby app

    chillout = Chillout::Client.new("YOUR-API-KEY")
    begin
      foo.boom!
    rescue SeriousException => exception
      chillout.send_exception(exception)
    end

## Chill out with Rack

    chillout = Chillout::Client.new("YOUR-API-KEY")
    use Chillout::Rack, chillout

## Chill out with Rails

Come later

## Configuration

    Chillout::Client.new("YOUR-API-KEY", platform: 'ruby')

    Chillout::Client.new("YOUR-API-KEY") do |config|
      config.platform = "ruby"
    end

    Chillout::Client.new("YOUR-API-KEY", platform: 'ruby') do
      config.port = 443
    end
