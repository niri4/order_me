class ApiCall
  require 'net/http'
  require 'json'
  def list
    uri = URI("http://192.168.3.3:3000/api/v1/template_list")
    a = Net::HTTP.get(uri)
     b= JSON.parse(a)
   p b["status"]
end
end
ApiCall.new.list
