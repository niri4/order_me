module ApiCall
  require 'net/http'
  require 'json'
  require "constant"
  require 'yaml'

  def self.authencation
    app_credentail = YAML.load_file('config/order_me.yml')
    email = app_credentail["order_me"]["email"]
    password = app_credentail["order_me"]["password"]
    app_token = app_credentail["order_me"]["app_token"]
    return app_token,email,password
  end

  def self.header_list
    auth = authencation
    uri = URI("#{API_URL}header_list?app_token=#{auth.first}&email=#{auth.second}&password=#{auth.third}")
    a = Net::HTTP.get(uri)
     b= JSON.parse(a)
     if  b["status"] == "true"
       return b,"true"
     else
       puts(b["message"])
       return b,"false"
     end
   end
   # TODO refactor make one funtion  header and footer
   def self.footer_list
     auth = authencation
     uri = URI("#{API_URL}footer_list?app_token=#{auth.first}&email=#{auth.second}&password=#{auth.third}")
     a = Net::HTTP.get(uri)
      b= JSON.parse(a)
      if  b["status"] == "true"
        return b
      else
        puts(b["message"])
      end
    end

    def self.template_search(key)
      auth = authencation
      uri = URI("#{API_URL}template_search")
      res = Net::HTTP.post_form(uri, 'key' => key,
                              'app_token' => auth.app_token,
                              'email'=> auth.email,
                              'password' => auth.password)
      b= JSON.parse(res.body)
      if  b["status"] == "true"
        return  b
      else
        puts(b["message"])
      end
    end


end
