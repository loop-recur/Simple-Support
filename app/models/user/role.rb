class User  
  module Role
    TYPES = %w(admin agent ticket_holder)
    
    def self.included(model)
      TYPES.each{ |r| User.send(:define_method, :"#{r}?") { role == r} }
      User.send(:define_method, :admin_access?) { admin? || agent? }
      model.after_initialize :set_role
      model.validates :role, :inclusion => {:in => TYPES}
      model.send(:attr_protected, :role)
    end
  end
  
  def set_role
    self[:role] ||= "ticket_holder"
  end
end
