require 'test_helper'

class CallTest < ActiveSupport::TestCase

  def time_at(str)
    Time.zone.parse(str)
  end

  setup do
    Proposal.delete_all
    Call.delete_all
  end

  test '.open scope with closing date' do
    Call.create(title: 'Call 1', closes_at: time_at('2012-05-31 23:59:59 CEST'))
    Call.create(title: 'Call 2', closes_at: time_at('2014-05-31 23:59:59 CEST'))
    Call.create(title: 'Call 3', closes_at: time_at('2015-05-31 23:59:59 CEST'))

    assert_equal 2, Call.open(time_at('2014-05-31 23:59:58 CEST')).count
    assert_equal 2, Call.open(time_at('2014-05-31 23:59:59 CEST')).count
    assert_equal 1, Call.open(time_at('2014-06-01 00:00:00 CEST')).count
    assert_equal 0, Call.open(time_at('2016-01-01 00:00:00 CEST')).count
  end

  test '.open scope with an opening and closing date' do
    Call.create(title: 'Call 4', opens_at:  time_at('2015-04-20 00:00:00 CEST'),
                                 closes_at: time_at('2015-04-21 23:59:59 CEST'))

    assert_equal 0, Call.open(time_at('2015-04-19 23:59:59 CEST')).count
    assert_equal 1, Call.open(time_at('2015-04-20 00:00:00 CEST')).count
    assert_equal 1, Call.open(time_at('2015-04-20 00:00:01 CEST')).count
  end

  test '#open? predicate with closing date' do
    call = Call.new(title: 'Call 1', closes_at: time_at('2014-10-31 23:59:59 CEST'))

    assert call.open?(time_at('2014-05-31 23:59:59 CEST'))
    refute call.open?(time_at('2014-11-01 00:00:00 CEST'))
  end

  test '#open? predicate with an opening and closing date' do
    call = Call.new(title: 'Call 4', opens_at:  time_at('2015-04-20 00:00:00 CEST'),
                                     closes_at: time_at('2015-04-21 23:59:59 CEST'))

    refute call.open?(time_at('2015-04-19 23:59:59 CEST'))
    assert call.open?(time_at('2015-04-20 00:00:00 CEST'))
    assert call.open?(time_at('2015-04-20 00:00:01 CEST'))
  end

end
