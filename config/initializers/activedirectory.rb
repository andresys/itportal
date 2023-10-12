require "active_directory"

ActiveDirectory::Base.setup({
  host: "172.30.5.1",
  base: "DC=adm,DC=local",
  port: 389,
  auth: {
    method: :simple,
    username: "administrator",
    password: "Rob!ng00d"
  }
})

# ActiveDirectory::Base.enable_cache