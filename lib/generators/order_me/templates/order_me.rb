
require "order_me"
begin
  OrderMe::Action.install
rescue Interrupt => e
  trap("SIGINT") { raise "Intrupted" }
end
