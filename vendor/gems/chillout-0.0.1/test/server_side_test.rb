require 'test_helper'
require 'time'

class ServerSideTest < ChilloutTestCase

  def setup
    @shell_env = { 'PATH' => '/bin:/usr/bin' }
    @api_key = "s3cr3t"
    @http_client = mock("HttpClient")

    @config = Chillout::Config.new(@api_key)
    @config.shell_environment = @shell_env
    @config.platform = "rails"
    @config.environment = "development"
    @config.notifier_name = "chillout"
    @config.version = "0.1"
    @config.notifier_url = "http://github.com/arkency/chillout"

    @controller = mock("Controller")
    @controller.stubs(:controller_name).returns("UsersController")
    @controller.stubs(:action_name).returns("index")

    @current_user = mock("User")
    @current_user.stubs(:id).returns(123)
    @current_user.stubs(:email).returns("john@example.com")
    @current_user.stubs(:full_name).returns("john doe")

    @server_side = Chillout::ServerSide.new(@config, @http_client)
    @exception = build_exception(NameError, "FooBar does not exists")
    @env = {
      'HTTP_USER_AGENT' => 'Mozilla/4.0',
      'action_controller.instance' => @controller,
      'current_user' => @current_user
    }
    @error = Chillout::Error.new(@exception, @env)
  end

  def test_event_type
    assert_param :event, 'exception'
  end

  def test_timestamp_is_iso8601
    @http_client.expects(:post).with { |_, params| Time.iso8601(params[:timestamp]) }
    @server_side.send_error(@error)
  end

  def test_exception_class
    assert_content :class, 'NameError'
  end

  def test_exception_message
    assert_content :message, 'FooBar does not exists'
  end

  def test_backtrace
    assert_content :backtrace, @exception.backtrace
  end

  def test_file
    assert_content :file, @error.file
  end

  def test_environment
    assert_content :environment, "development"
  end

  def test_platform
    assert_context :platform, "rails"
  end

  def test_controller
    assert_context :controller, "UsersController"
  end

  def test_action
    assert_context :controller, "UsersController"
  end

  def test_current_user_id
    assert_current_user :id, 123
  end

  def test_current_user_email
    assert_current_user :email, "john@example.com"
  end

  def test_current_user_full_name
    assert_current_user :full_name, "john doe"
  end

  def test_rack_environment
    expected_value = Hash[@env.collect { |k,v| [k, v.to_s] }]
    assert_content :rack_environment, expected_value
  end

  def test_shell_environment
    assert_content :shell_environment, @shell_env
  end

  def test_notifier_name
    assert_notifier :name, "chillout"
  end

  def test_notifier_version
    assert_notifier :version, "0.1"
  end

  def test_notifier_url
    assert_notifier :url, "http://github.com/arkency/chillout"
  end

  private
  def assert_param(key, value)
    @http_client.expects(:post).with('/events', has_entry(key, value))
    @server_side.send_error(@error)
  end

  def assert_content(key, value)
    assert_param(:content, has_entry(key, value))
  end

  def assert_context(key, value)
    assert_content(:context, has_entry(key, value))
  end

  def assert_current_user(key, value)
    assert_context(:current_user, has_entry(key, value))
  end

  def assert_notifier(key, value)
    assert_param(:notifier, has_entry(key, value))
  end

end
