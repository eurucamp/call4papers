class AssociatePapersWithCalls < ActiveRecord::Migration
  class Call  < ActiveRecord::Base; end
  class Paper < ActiveRecord::Base; end

  def change
    add_column :papers, :call_id, :integer

    Paper.reset_column_information
    reversible do |dir|
      dir.up do
        jrubyconf_call = Call.find_or_create_by!(title: 'JRubyConf EU 2013') do |c|
          c.closes_at = Time.zone.parse('2013-05-31 23:59:59 CEST')
        end

        eurucamp_call = Call.find_or_create_by!(title: 'eurucamp 2013') do |c|
          c.closes_at = Time.zone.parse('2013-05-15 23:59:59 CEST')
        end

        Paper.where(track: 'JRubyConf EU').update_all(call_id: jrubyconf_call.id)
        Paper.where(call_id: nil).update_all(call_id: eurucamp_call.id)
      end
    end

    change_column_null :papers, :call_id, false
  end
end
