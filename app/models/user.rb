require 'digest/sha1'
class User < ActiveRecord::Base
  # ---------------------------------------
  # The following code has been generated by role_requirement.
  # You may wish to modify it to suit your need
  has_and_belongs_to_many :roles
  
  # has_role? simply needs to return true or false whether a user has a role or not.  
  # It may be a good idea to have "admin" roles return true always
  def has_role?(role_in_question)
    @_list ||= self.roles.collect(&:name)
    return true if @_list.include?("admin")
    (@_list.include?(role_in_question.to_s) )
  end
  # ---------------------------------------

  belongs_to :rol
  has_many :transferencias

  def self.authenticate(login, pass)
    find(:first, :conditions => ["login = ? AND password = ?", login, sha1(pass)])
  end

  def self.autenticar(login,pass)
      find(:first, :conditions => ["login = ? AND password = ?", login, sha1(pass)])
  end

  def change_password(pass)
    update_attribute "password", self.class.sha1(pass)
  end

  protected

  def self.sha1(pass)
    Digest::SHA1.hexdigest("change-me--#{pass}--")
  end

  before_create :crypt_password
  #before_save :crypt_password

  def crypt_password
    write_attribute("password", self.class.sha1(password))
  end

  validates_length_of :login, :within => 3..40, :message => "La longitud del login es de 3 a 40 caracteres"
  validates_length_of :password, :within => 5..40, :message => "La longitud del password es de 5 a 40 caracteres"
  validates_presence_of :login, :password, :password_confirmation, :message => "Es necesaria la confirmacion del password"
  validates_uniqueness_of :login, :on => :create, :message => "ese usuario ya existe"
  validates_confirmation_of :password, :on => :create

end
