module ExceptionCall

  def self.interrupt
    trap("SIGINT") { raise "Intrupted"}
    exit
  end
end
