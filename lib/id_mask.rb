module IDMask
extend self

  def unmask(masked_id)
    no_new_lines = masked_id.gsub("SLASH", "/").gsub("NEWLINE", '\\n')
    EzCrypto::Key.with_password("bubble", "gum").decrypt64(no_new_lines).split(",")
  end
  
  def mask(*args)
    EzCrypto::Key.with_password("bubble", "gum").encrypt64(args.join(',')).gsub("/", "SLASH").gsub(/\n/, "NEWLINE")
  end
  
end
