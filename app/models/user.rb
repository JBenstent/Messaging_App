class User < ActiveRecord::Base
  validates :email, uniqueness: true

  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
  has_many :recieved_messages, class_name: 'Message', foreign_key: 'recipient_id'
  has_many :out_contacts, -> {distinct}, class_name: 'User', through: 'sent_messages', source: 'recipient'
  has_many :in_contacts, -> {distinct}, class_name: 'User', through: 'recieved_messages', source: 'sender'

  def all_contacts
    (out_contacts + in_contacts).uniq
  end
end
