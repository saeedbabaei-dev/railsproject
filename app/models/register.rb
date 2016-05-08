class Register < ActiveRecord::Base
  attr_accessible :username, :email, :password_hash, :password_salt,:auth_token, :password, :password_confirm,:remember_me
  attr_accessor :password, :password_confirm, :remember_me
  before_save :encript_password
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :on => :create
  validates_presence_of :username, :on => :create
  validates :email, email: {strict_mode: true}
  #validates_uniqueness_of :email
  #validates_uniqueness_of :username
  before_create { generate_token(:auth_token) }
  
def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end 
    while Register.exists?(column => self[column])
end
end
  def self.authenticate_by_username(username, password)
     
    user =Register.find_by_username(username)  
    if user && user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
      user  
    else  
      nil  
    end   
end
def self.authenticate_by_email(email, password)
     
    user =Register.find_by_email(email)  
    if user && user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
      user  
    else  
      nil  
    end   
end
  def encript_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
