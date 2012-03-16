# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'digest'	#used for encrypting passwords

class User < ActiveRecord::Base

	attr_accessor :password
	attr_accessible(:name, :email, :password, :password_confirmation)	#make these attributes accessible

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  ### USER ATTRIBUTE VALIDATIONS #########################################
	validates(:name, :presence => true,																#checks for name
									 :length   => { :maximum => 50 })									#restricts name length

	validates(:email, :presence   => true,														#checks for email
										:format     => { :with => email_regex },				#checks email format
										:uniqueness => { :case_sensitive => false })		#check address uniqueness regardless of case

  # Automatically creates the virtual attribute 'password_confirmation'.
  validates :password, :presence     => true,                       #checks for password
                       :confirmation => true,                       #checks for password confirmation
                       :length       => { :within => 6..40 }        #checks password length
  ########################################################################

  before_save :encrypt_password

  ### PASSWORD AUTHENTICATION ############################################
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = User.find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  ########################################################################

  private
    
    ### PASSWORD ENCRYPTION ##############################################
    def encrypt_password
      self.salt = make_salt unless has_password?(self.password)
      self.encrypted_password = encrypt(self.password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    ######################################################################
end