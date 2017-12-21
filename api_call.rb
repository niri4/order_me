class ApiCall
  require 'net/http'
  require 'json'
  attr_reader :first_link,:second_link,:third_link
  def header_list
    uri = URI("http://192.168.3.3:3000/api/v1/header_list")
    a = Net::HTTP.get(uri)
     b= JSON.parse(a)
     if  b["status"] == "true"
          $first_link = b["template"].first
          $second_link = b["template"][1]
          $third_link = b["template"][2]
     else
     end
   end
   def footer_list
     uri = URI("http://192.168.3.3:3000/api/v1/footer_list")
     a = Net::HTTP.get(uri)
      b= JSON.parse(a)
      if  b["status"] == "true"
           $first_link = b["template"].first
           $second_link = b["template"][1]
           $third_link = b["template"][2]
      else
      end
    end
end
