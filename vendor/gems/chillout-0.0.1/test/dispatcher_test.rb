require 'test_helper'

class DispatcherTest < ChilloutTestCase

  def test_error_dispatch
    exception = build_exception(NameError)
    env = {
      "HTTP_USER_AGENT" => "Mozzila/4.0",
      "rack.session" => {}
    }
    error = Chillout::Error.new(exception, env)

    filter = mock("Filter")
    filter.expects(:deliver_error?).with(error).returns(true)

    server_side = mock("ServerSide")
    server_side.expects(:send_error).with(error)

    dispatcher = Chillout::Dispatcher.new(filter, server_side)
    dispatcher.dispatch_error(error)
  end

  def test_ignored_error_dispatch
    exception = build_exception(NameError)
    env = {
      "HTTP_USER_AGENT" => "Mozzila/4.0",
      "rack.session" => {}
    }
    error = Chillout::Error.new(exception, env)

    filter = mock("Filter")
    filter.expects(:deliver_error?).with(error).returns(false)

    server_side = mock("ServerSide")

    dispatcher = Chillout::Dispatcher.new(filter, server_side)
    dispatcher.dispatch_error(error)
  end

end
