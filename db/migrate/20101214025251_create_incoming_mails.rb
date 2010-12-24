class CreateIncomingMails < ActiveRecord::Migration
  def self.up
    create_table :incoming_mails do |t|
      t.string :from
      t.string :to
      t.string :reply_to
      t.string :subject
      t.text :body
      t.timestamp :sent_at
      t.timestamp :processed_at
      t.timestamps
    end
  end

  def self.down
    drop_table :incoming_mails
  end
end
