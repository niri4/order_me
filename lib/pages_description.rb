require "action"
require_relative "api_call"
require 'json'
require "constant"
require "exceptional_call"
class PagesDescription
  include ApiCall
  def pages_select
    pages = ""
    input_pages = ""
    page_line = ""
    count = 0
    until page_line.strip == "q"
      print("?- ")
      page_line  = gets
      begin
        case(page_line.strip)
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
      rescue SystemExit, Interrupt
        ExceptionCall.method(:interrupt).call
      rescue Exception => e
         raise "Abort!! , some Error Occur #{e.message}"
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
    get_header(header_list)
    puts("Footer list")
    get_footer(footer_list)
  end

  def get_header(header)
    header_choice = header
    if header_choice[0].to_i == 4
       header = header_view_more
    else
      header = header_choice[1]
    end
    partial_call(header,"header")
  end
  def get_footer(footer)
    footer_choice = footer
    if footer_choice[0].to_i == 4
       footer = footer_view_more
    else
      footer = footer_choice[1]
    end
      partial_call(footer,"footer")
  end
  def partial_call(key,category)
    template_param = api_fetch(key)
    html_file = template_param[0]
    css_file = template_param[1]
    if template_param[2] !=nil
      js_file = template_param[2]
      partial_create(html_file,css_file,js_file,category)
    else
      js_file = nil
      partial_create(html_file,css_file,js_file,category)
    end
  end

  def partial_create(html_file,css_file,js_file,category)
    Action.new.new_file!(html_file,"_#{category}.html.erb","views/shared")
    Action.new.new_file!(css_file,"#{category}.css","assets/stylesheets")
    if category == "header"
      Action.new.insert_into_file!("before","views/layouts/application.html.erb"," render 'shared/header'","yield")
      Action.new.append_file!("app/assets/stylesheets/order_me_application.css.scss","@import 'header';")
    else
      Action.new.insert_into_file!("after","views/layouts/application.html.erb"," render 'shared/footer'","yield")
      Action.new.append_file!("app/assets/stylesheets/order_me_application.css.scss","@import 'footer';")
    end
    if js_file != nil
      Action.new.new_file!(js_file,"#{category}.js","assets/javascripts")
    else
    end
  end

  def api_fetch(key)
    template = ApiCall.template_search(key)
    html_file = "#{WEB_URL}#{template["template"]["file"]["url"]}"
    css_file = "#{WEB_URL}#{template["template"]["css_file"]["url"]}"
    if template["template"]["js_file"] == nil
      js_file = "#{WEB_URL}#{template["template"]["js_file"]["url"]}"
      return html_file,css_file,js_file
    else
      return html_file,css_file
    end
  end
  def header_only
    get_header(header_list)
  end
  def footer_only
    get_footer(footer_list)
  end
  def header_list
    a= ApiCall.header_list
    puts("Enter Your Choice about Header")
    puts("click on link to preview the header")
    puts("1.header first #{"#{WEB_URL}templates/#{a["template"].first["id"]}"}")
    puts("2.header second #{"#{WEB_URL}templates/#{a["template"][1]["id"]}"}")
    puts("3 header third #{"#{WEB_URL}templates/#{a["template"][2]["id"]}"}")
    puts("4. View More #{"#{WEB_URL}templates/"}")
    choice = gets()
    if choice.to_i > 4
      header_list
    else
      hader = {}
      hader = a["template"][(choice.to_i - 1)]["key"]
      return choice,hader
    end
  end

  def header_view_more
    puts("Enter Your key to apply that Header")
    key = gets
  end
  def footer_view_more
    puts("Enter Your key to apply that Footer")
    key = gets
  end

  def footer_list
    a= ApiCall.footer_list
    puts("Enter Your Choice about Footer")
    puts("click on link to preview the Footer")
    puts("1.Footer first #{"#{WEB_URL}templates/#{a["template"].first["id"]}"}")
    puts("2.Footer second #{"#{WEB_URL}templates/#{a["template"][1]["id"]}"}")
    puts("3 Footer third #{"#{WEB_URL}templates/#{a["template"][2]["id"]}"}")
    puts("4. View More #{"#{WEB_URL}templates/"}")
    choice = gets()
    if choice.to_i > 4
      footer_list
    else
      foter = {}
      foter = a["template"][(choice.to_i - 1)]["key"]
      return choice,foter
    end
  end
end
