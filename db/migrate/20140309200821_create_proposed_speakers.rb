class CreateProposedSpeakers < ActiveRecord::Migration
  def change
    create_table :proposed_speakers do |t|
      t.integer :inviter_id
      t.integer :call_id
      t.string :speaker_name
      t.string :speaker_email
      t.text :reason

      t.timestamps
    end
    add_index :proposed_speakers, :inviter_id
    add_index :proposed_speakers, :call_id
  end
end
