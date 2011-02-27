# == Schema Information
# Schema version: 20110118220348
#
# Table name: users
#
#  id                 :integer(4)      not null, primary key
#  email              :string(255)     not null
#  encrypted_password :string(255)     not null
#  first_name         :string(255)     not null
#  last_name          :string(255)     not null
#  last_login         :datetime        default(2011-02-21 00:00:00 UTC)
#  created_at         :datetime
#  updated_at         :datetime
#  salt               :string(255)     not null
#

# == Schema Information
# Schema version: 20110118174920
#
# Table name: users
#
#  id                 :integer(4)      not null, primary key
#  email              :string(255)     not null
#  encrypted_password :string(255)     not null
#  first_name         :string(255)     not null
#  last_name          :string(255)     not null
#  last_login         :datetime        default(2011-01-18 00:00:00 UTC)
#  created_at         :datetime
#  updated_at         :datetime
#
require 'digest'

class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  attr_accessor :password

  has_many :events, :through => :coordinators
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => true
  validates :first_name, :presence => true,
                         :length => { :maximum => 30 }
  validates :last_name, :presence => true,
                        :length => { :maximum => 30 }
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..40 }
                       
  before_save :encrypt_password
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  private
  
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end
  
  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end
  
  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end
  
  def secure_hash(string)
    Digest::SHA256.hexdigest(string)
  end
end
