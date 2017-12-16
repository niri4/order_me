require "./action"
class PagesDescription
  def pages_select
    pages = ""
    input_pages = ""
    page_line = ""
    count = 0
    until page_line.strip() == "q"
      print("?- ")
      page_line  = gets()
      case(page_line.strip())
      when '1'
        if count < 1
        puts("1. one page app selected ")
        page_heading(1)
        end
        count= 1
          pages += input_pages
      when '2'
        if count < 1
          puts("2. 2 page app selected")
          page_heading(2)
        end
        count= 1
        pages += input_pages
      when '3'
        if count < 1
          puts("3. Three page app selected ")
          page_heading(3)
        end
        count =1
          pages += input_pages
        when '4'
          puts("4. Define Yourself choice selected")
          puts("Aceept only numeric values")
          puts("enter the pages")
          value = gets()
          if value.to_i != 0
            if count < 1
              puts("4. According to your request pages select #{value.to_i}")
              page_heading(value.to_i)
            else
              count =0
            end
          else
            puts("Enter Wrong Choice.. please Enter Only Numeric Value.")
            puts("Your Choice is selected as Manually.")
            puts("You Need To Tell Us")
            puts("How many pages you want in app")
            puts("1. one page")
            puts("2. two pages")
            puts("3. three pages")
            puts("4. Define Yourself")
          end
      else
        input_pages +=page_line
      end
    end
  end

  def page_heading(page_count)
    puts("Enter Pages headings")
    puts("plaese make sure write with comma seprated eg home,about us,contact us.")
    page_get = gets()
    a= page_get.split(',')
    if a.length == page_count
      @@page_get = page_get
      page_get.split(',').each do |page_name|
        Action.new.empty_directory! page_name
      end
      puts("you Have selected #{page_count} pages,pages name is #{@@page_get}")
      exit()
    else
      puts("Please Enter the pages correctly")
      page_heading(page_count)
    end
  end

  # def layout_choice
  #   puts("Enter Your choice about layout")
  #   puts("1. Want Common Header And Footer")
  #   puts("2. Header Only")
  #   puts("3. Footer Only")
  #   puts("4. Make Seprate Header and Footer for every Pages")
  #   #layout_choice
  # end

end
