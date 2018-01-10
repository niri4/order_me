module ApiCall
  require 'net/http'
  require 'json'
  require "constant"

  def self.header_list
    uri = URI("#{API_URL}header_list")
    a = Net::HTTP.get(uri)
     b= JSON.parse(a)
     if  b["status"] == "true"
          return b
     else
     end
   end
   # TODO refactor make one funtion  header and footer
   def self.footer_list
     uri = URI("#{API_URL}footer_list")
     a = Net::HTTP.get(uri)
      b= JSON.parse(a)
      if  b["status"] == "true"
           return b
      else
      end
    end

    def self.template_search(key)
      uri = URI("#{API_URL}template_search")
      res = Net::HTTP.post_form(uri, 'key' => key)
      b= JSON.parse(res.body)
      if  b["status"] == "true"
           return  b
      else
      end
    end


end
