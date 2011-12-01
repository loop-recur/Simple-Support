module LinksHelper
  
  def toggle_action(positive, negative, object, selector)
    bool = object.send(selector)
    text = bool ? negative : positive
    name = object.class.name.underscore.to_sym
    button_to(text, send(:"admin_#{name}_path", object.id, name => {selector => !bool}), :method => :put)
  end
  
end
