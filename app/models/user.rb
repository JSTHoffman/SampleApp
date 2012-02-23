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

class User < ActiveRecord::Base

	attr_accessible(:name, :email)	#make name and email accessible

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates(:name,  :presence => true,								#checks for name
										:length   => { :maximum => 50 })	#restricts name length

	validates(:email, :presence   => true,													#checks for email
										:format     => { :with => email_regex },			#checks email format
										:uniqueness => { :case_sensitive => false })	#check address uniqueness regardless of case

end