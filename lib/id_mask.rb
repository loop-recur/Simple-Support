module IDMask
extend self

  def unmask(masked_id)
    sanitized = masked_id.gsub("SLH", "/").gsub("NWLN", "\n")
    JSON.parse(EzCrypto::Key.with_password("bubble", "gum").decrypt64(sanitized)).symbolize_keys!
  end
  
  def mask(*args)
    json = args.map(&:to_json).join(",")
    EzCrypto::Key.with_password("bubble", "gum").encrypt64(json).gsub("/", "SLH").gsub("\n", "NWLN");
  end
  
end
