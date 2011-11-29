class User
  
class Admin < User
  has_attached_file :avatar, PAPERCLIP_DEFAULTS.merge(:default_url => ":class/:style.png",
                                                      :default_style => :default,
                                                      :styles => { :default => "87x87#"})

end

end
