require "order_me/version"
require "pages_description"
require "exceptional_call"
module OrderMe

  class Action
    def self.install
      puts("Hello, Welcome to Order Me Hold Tight For Reveolution.")
      puts("Enter Your Choices")
      puts("1. Manually")
      puts("2. Speaking")
      puts("Enter Q  or ctrl +c to Quit")
      program = ""
      input = ""
      line = ""
      until line.strip == "q"
        print("?- ")
          line  = gets
          begin
            case(line.strip)
            when '1'
              puts("Your Choice is selected as Manually.")
              puts("You Need To Tell Us")
              puts("How many pages you want in app")
              program += input
              input = ""
              puts("1. one page")
              puts("2. two pages")
              puts("3. three pages")
              puts("4. Define Yourself")
              PagesDescription.new.pages_select
            when '2'
              puts("Your Choice is Selected as Speaking.")
              puts( "soonly coming" )
              exit
            else
              puts("Enter something wrong choice will be an integer")
              input +=line
            end
          rescue SystemExit, Interrupt
            ExceptionCall.method(:interrupt).call
          rescue Exception => e
             raise "Abort!! , some Error Occur #{e.message}"
          end
      end

    end
  end
  # Your code goes here...
end
