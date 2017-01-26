class AssociatePapersWithCalls < ActiveRecord::Migration
  class Call  < ActiveRecord::Base; end
  class Paper < ActiveRecord::Base; end

  def change
    add_column :papers, :call_id, :integer

    Paper.reset_column_information

    change_column_null :papers, :call_id, false
  end
end
