class AddTalkReferenceToProposal < ActiveRecord::Migration
  def change
    add_column :proposals, :talk_id, :string
  end
end
