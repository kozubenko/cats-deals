module ApiSources
  class BaseSource
    include InterfaceMethodConcern

    define_interface_method(%i[fetch_url options handle_response])
  end
end
