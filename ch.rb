puts("write a program interactively")
puts("Enter a blank line to evaluate")
puts("Enter Q to Quit")
program = ""
input = ""
line = ""
until line.strip() == "q"
  print("?- ")
  line  = gets()
  case(line.strip())
  when ''
    puts("Evaluating ... ")
    eval( input)
    program += input
    input = ""
  when '1'
    puts("Program listing....")
    puts( program )
  else
    input +=line
  end
end
