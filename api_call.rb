module ApiCall
  require 'net/http'
  require 'json'

  def self.header_list
    uri = URI("http://192.168.3.3:3000/api/v1/header_list")
    a = Net::HTTP.get(uri)
     b= JSON.parse(a)
     if  b["status"] == "true"
          return b
     else
     end
   end
   # TODO refactor make one funtion  header and footer
   def footer_list
     uri = URI("http://192.168.3.3:3000/api/v1/footer_list")
     a = Net::HTTP.get(uri)
      b= JSON.parse(a)
      if  b["status"] == "true"
           return b
      else
      end
    end
end
