require "./pages_description"
class Speak
  puts("Hello, Welcome to Order Me Hold Tight For Reveolution.")
  puts("Enter Your Choices")
  puts("1. Manualy")
  puts("2. Speking")
  puts("Enter Q to Quit")
  program = ""
  input = ""
  line = ""
  until line.strip() == "q"
    print("?- ")
    line  = gets()
    case(line.strip())
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
      exit()
    else
      input +=line
    end
  end
end
