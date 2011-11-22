class User
module Factory
  extend self
  
  def self.create(attrs)
    password = PasswordGenerator.generate!
    attrs.merge!(:password => password, :password_confirmation => password)
    User.find_or_create_by_email(attrs)
  end
  
end
end
