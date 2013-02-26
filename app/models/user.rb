class User
  include DataMapper::Resource
 
  property :id,              Serial
  property :name,            String
  property :password,        BCryptHash
 
  timestamps :at
 
  attr_accessor :password_confirmation
 
  validates_presence_of     :name
  validates_uniqueness_of   :name
  validates_confirmation_of :password
 
  validates_with_method :password_non_blank
 
  # Public class method than returns a user object if the caller supplies the correct name and password
  #
  def self.authenticate(name, password)
    user = first(:name => name)
    if user
      if user.password != password
        user = nil
      end
    end
    user
  end
 
  private
 
  def password_non_blank
    if password_confirmation.nil? || password_confirmation.empty?
      [ false, 'Missing password']
    else
      true
    end
  end
 
end
