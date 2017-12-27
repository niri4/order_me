require "./action"
require_relative "./api_call"
require 'json'
class PagesDescription
  include ApiCall
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
      layout_choice
      exit()
    else
      puts("Please Enter the pages correctly")
      page_heading(page_count)
    end
  end

  def layout_choice
    puts("Enter Your choice about layout")
    puts("1. Want Common Header And Footer")
    puts("2. Header Only")
    puts("3. Footer Only")
    puts("4. Make Seprate Header and Footer for every Pages")
    layout = ""
    input_layout = ""
    line_layout = ""
    count =0
    until line_layout.strip() == "q"
      print("?- ")
      line_layout  = gets()
      case(line_layout.strip())
      when '1'
        if count == 0
          common_header_footer
          count+= 1
          exit()
        else
          exit()
        end
      when '2'
        if count == 0
          header_only
          count+= 1
          exit()
        else
          exit()
        end
      when '3'
        if count == 0
          footer_only
          count+= 1
          exit()
        else
          exit()
        end
      when '4'
        puts("Additional function come in future")
        layout_choice
      else
        puts("Please enter your choice in these option only.")
        layout_choice
      end
    end
  end
  def common_header_footer
    puts("You have selected common Header and Footer")
    puts("Given a choice to select header of your choice")
    puts("Header list")
    header_choice = header_list
    if header_choice.to_i == 4
       header = header_view_more
    else
      header = header_choice.to_i
    end
    puts("Footer list")
    footer_choice = footer_list
    if footer_choice.to_i == 4
       footer = footer_view_more
    else
      footer = footer_choice.to_i
    end
  end
  def header_only
    header_list
  end
  def footer_only
    footer_list
  end
  def header_list
    a= ApiCall.header_list

    puts("Enter Your Choice about Header")
    puts("click on link to preview the header")
    puts("1.header first #{"http://192.168.3.3:3000/templates/#{a["template"].first["id"]}"}")
    puts("2.header second #{"http://192.168.3.3:3000/templates/#{a["template"][1]["id"]}"}")
    puts("3 header third #{"http://192.168.3.3:3000/templates/#{a["template"][2]["id"]}"}")
    puts("4. View More #{"http://192.168.3.3:3000/templates/"}")
    choice = gets()
    if choice.to_i > 4
      header_list
    else
      return choice
    end
  end

  def header_view_more
    puts("Enter Your key to apply that Header")
    key = gets()
    #TOdo need to be implemented
    #download_header(key)
  end
  def footer_view_more
    puts("Enter Your key to apply that Footer")
    key = gets()
    #Todo need to be implemented
    #download_footer(key)
  end

  def footer_list
    puts("Enter Your Choice about Header")
    puts("click on link to preview the Footer")
    puts("1.Footer first #{"http://www.google.com"}")
    puts("2.Footer second #{"http://www.facebook.com"}")
    puts("3 Footer third #{"http://www.twitter.com"}")
    puts("4. View More #{"http://www.youtube.com"}")
    choice = gets()
    if choice.to_i > 4
      footer_list
    else
      return choice
    end
  end
end
