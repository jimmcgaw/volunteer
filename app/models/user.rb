# == Schema Information
# Schema version: 20110227014344
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

  has_many :locations
  has_many :organizations
  has_many :authentications
  
  has_many :coordinators
  has_many :events, :through => :coordinators
  
  has_many :managers
  has_many :organizations, :through => :managers
  
  has_many :registrations
  has_many :shifts, :through => :registrations
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => true
  validates :first_name, :presence => true,
                         :length => { :maximum => 30 },
                         :if => :password_required?
  validates :last_name, :presence => true,
                        :length => { :maximum => 30 },
                         :if => :password_required?
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..40 },
                        :if => :password_required?
                       
  before_save :encrypt_password
  before_create :populate_null
  
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
  
  def apply_omniauth(omniauth)
    puts "Is email blank?" + self.email.blank?.to_s
    puts "Oauth email :" + omniauth['user_info']['email']
    self.email = omniauth['user_info']['email'] if email.blank?
    self.first_name = omniauth['user_info']['first_name'] if first_name.blank?
    self.last_name = omniauth['user_info']['last_name'] if last_name.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
  
  def password_required?
    authentications.empty? || !password.blank?
  end
  
  private
  
  def populate_null
    unless password_required?
      self.first_name = "" if self.first_name.nil?
      self.last_name = "" if self.last_name.nil?
    end
  end
  
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
