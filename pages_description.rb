
class PagesDescription
  def pages_select
    pages = ""
    input_pages = ""
    page_line = ""
    until page_line.strip() == "q"
      print("?- ")
      page_line  = gets()
      case(page_line.strip())
      when '1'
        puts("1. one page app selected ")
          pages += input_pages
      when '2'
        puts("2. 2 page app selected ")
        pages += input_pages
      when '3'
        puts("3. Three page app selected ")
          pages += input_pages
      else
        input_pages +=page_line
      end
    end
  end

end
