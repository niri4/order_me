require "action"
require_relative "api_call"
require 'json'
require "constant"
require "exceptional_call"
require "shared_method"
class PagesDescription
  include ApiCall
  def pages_select
    pages = ""
    input_pages = ""
    page_line = ""
    count = 0
    until page_line.strip == "q"
      print("?- ")
      page_line  = SharedMethod.method(:gets_setting).call
      begin
        case(page_line.strip)
        when '1'
          if count < 1
          puts("1. one page app selected ")
          page_heading(1) if !SharedMethod.method(:test_env?).call
          end
          count= 1
            pages += input_pages
            break
        when '2'
          if count < 1
            puts("2. Two page app selected")
            page_heading(2) if !SharedMethod.method(:test_env?).call
          end
          count= 1
          pages += input_pages
          break
        when '3'
          if count < 1
            puts("3. Three page app selected ")
            page_heading(3) if !SharedMethod.method(:test_env?).call
          end
          count =1
            pages += input_pages
            break
          when '4'
            puts("4. Define Yourself choice selected")
            puts("Aceept only numeric values")
            puts("enter the pages")
            value = SharedMethod.method(:gets_setting).call()
            if value.to_i != 0
              if count < 1
                puts("4. According to your request pages select #{value.to_i}")
                page_heading(value.to_i) if !SharedMethod.method(:test_env?).call
                break
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
          puts("Something went wrong")
          puts("Enter Wrong Choice.. please Enter Only Numeric Value.")
          puts("Select from start")
          puts("You Need To Tell Us")
          puts("How many pages you want in app")
          puts("1. one page")
          puts("2. two pages")
          puts("3. three pages")
          puts("4. Define Yourself")
          input_pages +=page_line
        end
      rescue SystemExit, Interrupt
        ExceptionCall.method(:interrupt).call
      rescue Exception => e
         puts "Abort!! , some Error Occur #{e.message}"
      end
    end
  end

  def page_heading(page_count)
    puts("Enter Pages headings")
    puts("plaese make sure write with comma seprated eg home,about us,contact us.")
    page_get = SharedMethod.method(:gets_setting).call
    a= page_get.split(',')
    if a.length == page_count && a.first != nil
      if a.grep(/\A\D/).length == page_count
        @@page_get = page_get
        page_get.split(',').each do |page_name|
          store_type_choice?(page_name) if !SharedMethod.method(:test_env?).call
        end
        puts("Want to set root (y/enter)")
        root_choice = SharedMethod.method(:gets_setting).call
        if root_choice.strip == "y"
          puts("here the route display select from it")
          root_display
        else
          puts("Root remain unchanged")
        end
        puts("you Have selected #{page_count} pages,pages name is #{@@page_get}")
        layout_choice if !SharedMethod.method(:test_env?).call

      else
        puts("page heading should not contain numeric at start")
        method(__method__).call(page_count) if !SharedMethod.method(:test_env?).call
      end
    else
      puts("Please Enter the pages correctly")
      method(__method__).call(page_count) if !SharedMethod.method(:test_env?).call
    end
  end

  def self.root_display
    puts(`cat config/routes.rb | grep get`)
    puts ("select your chioce via follow the right display side for eg static#home")
    root_make
  end

  def root_make
    puts("Enter Your Choice")
    root = SharedMethod.method(:gets_setting).call
    if root.include?("#")
      root_check = `cat config/routes.rb | grep -F -w #{root.strip}`
      if !root_check.blank?
        vintage_root = `cat config/routes.rb | grep -F -w root`
        if !vintage_root.blank?
          vintage_root.strip.split("\"").last
          Action.new.insert_into_file!("after","config/routes.rb",
            %Q(\n\t get "#{vintage_root.strip.split("\"").last.split("#").first.strip.downcase + '/' + vintage_root.strip.split("\"").last.split("#").last.strip.downcase}" => "#{vintage_root.strip.split("\"").last}"),
            "Rails.application.routes.draw do")
        end
        Action.new.replacement_in_file!("config/routes.rb",vintage_root.strip,%Q(root "#{root.strip}"))
        Action.new.replacement_in_file!("config/routes.rb",%Q( get "#{root.strip.split('#').first + "/" + root.strip.split('#').last}" => "#{root.strip}"),'\1')
      else
        puts("you enter worng route name please make sure. you enter correctly")
        method("root_display".to_sym).call
      end
    else
      puts("you enter worng route name please make sure. you enter correctly")
      method("root_display".to_sym).call
    end
  end

  def store_type_choice?(page_name)
    puts("Did you want directory or a single file")
    puts("1. want Directory")
    puts("2. want file at single storage")
    store_type_choice = SharedMethod.method(:gets_setting).call
    case(store_type_choice.strip)
    when '1'
      want_directory?(page_name)
    when '2'
      want_file_store?(page_name)
    else
      puts("Enter valid choice")
      store_type_choice?(page_name)
    end
  end

  def want_directory?(page_name)
    puts("Your selected choice is directory")
    puts("want to revert your decision (y/n)")
    revert_choice = SharedMethod.method(:gets_setting).call
    if revert_choice.strip == "y" || revert_choice.strip == "Y"
      begin
        puts("Your choice select as Directory would be revert back select again your choice.")
        method((caller[0][/`([^']*)'/, 1]).to_sym).call(page_name) if !SharedMethod.method(:test_env?).call
      rescue
        puts("Your choice select as Directory would be revert back select again your choice.")
        store_type_choice?(page_name) if !SharedMethod.method(:test_env?).call
      end
    else
      puts("Enter Directory name")
      directory_name = SharedMethod.method(:gets_setting).call
      if directory_name.strip.empty?
        puts("Directory Name cannot be empty.")
        method(__method__).call(page_name) if !SharedMethod.method(:test_env?).call
      else
        if !check_formet(directory_name.strip)
          puts("Enter file location")
          puts("NOTE: Enter location in between your app by default app/views")
          puts("Example: app/views")
          file_location = SharedMethod.method(:gets_setting).call
          if file_location.strip.empty?
            puts("location chosen as app/views")
            file_location = "app/views"
          end
          puts("by default file_name is #{page_name.strip} want to change press N or n")
          page_name_choice = SharedMethod.method(:gets_setting).call
          if page_name_choice.strip == "n" || page_name_choice.strip ==  "N"
            puts("Enter your File Name")
            puts("Example: for html.erb file type only file name home not home.html.erb")
            file_name = SharedMethod.method(:gets_setting).call
          else
            file_name = page_name.strip
          end
          result= !(SharedMethod.method(:test_env?).call )? (!File.read("config/routes.rb").include?(%Q(get "#{directory_name.strip.downcase + '/' + file_name.strip}" => "#{directory_name.strip.downcase}##{file_name.strip}") )) : true
          if !check_formet(file_name.strip) && (result)
            Action.new.new_file_manual_loc!(file_location.strip + "/" + directory_name.strip.downcase,file_name.strip + ".html.erb") if !SharedMethod.method(:test_env?).call
            puts("Your File has been created as #{file_location.strip}/#{directory_name.strip}/#{file_name.strip}.html.erb")
            define_routes(directory_name,file_name) if !SharedMethod.method(:test_env?).call
          else
            puts("file_name should not contain numeric at start or already register route with this action")
            method(__method__).call(page_name) if !SharedMethod.method(:test_env?).call
          end
        else
          puts("directory_name should not contain numeric at start")
          method(__method__).call(page_name) if !SharedMethod.method(:test_env?).call
        end
      end
    end
  end

  def define_controller(directory_name,file_name)
    controller = controller_struc(directory_name,file_name)
    File.open("app/controllers/" + directory_name.downcase + "_controller.rb", 'w') { |file| file.write(controller) }
  end
  def controller_struc(directory_name,file_name)
    return %Q(class #{directory_name.classify}Controller < ApplicationController\n\tdef #{file_name}\n\tend\nend)
  end

  def add_action_to_controller(directory_name,file_name)
    Action.new.insert_into_file!("after","app/controllers/" + directory_name.downcase + "_controller.rb",
      %Q(\n\tdef #{file_name}\n\tend),
      "class #{directory_name.classify}Controller < ApplicationController")
  end

  def check_formet(file_name)
    file_name.scan(/\A\D/).empty?
  end

  def define_routes(directory_name,file_name)
    puts("Define contrroller name as app/controllers/#{directory_name.strip.downcase}_controller.rb")
    if !File.file?("app/controllers/#{directory_name.strip.downcase}_controller.rb")
      Action.new.new_file_manual_loc!("app/controllers/",directory_name.strip.downcase + "_controller.rb")
      puts("defining controller")
      define_controller(directory_name.strip,file_name.strip)
    else
      puts("Adding the action to the controller")
      add_action_to_controller(directory_name.strip,file_name.strip)
    end
    puts("routes define as GET request")
    Action.new.insert_into_file!("after","config/routes.rb",
      %Q(\n\t get "#{directory_name.strip.downcase + '/' + file_name.strip}" => "#{directory_name.strip.downcase}##{file_name.strip}"),
      "Rails.application.routes.draw do")
  end

  def want_file_store?(page_name)
    puts("Your Selected Choice is file at single storage")
    puts("want to revert your decision (y/n)")
    revert_choice = SharedMethod.method(:gets_setting).call
    if revert_choice.strip == "y" || revert_choice.strip == "Y"
      begin
        puts("Your choice select as single storage would be revert back select again your choice.")
        method((caller[0][/`([^']*)'/, 1]).to_sym).call(page_name) if !SharedMethod.method(:test_env?).call
      rescue
        puts("Your choice select as single storage would be revert back select again your choice.")
        store_type_choice?(page_name) if !SharedMethod.method(:test_env?).call
      end
    else
      puts("by default file_name is #{page_name.strip} want to change press N or n")
      page_name_choice = SharedMethod.method(:gets_setting).call
      if page_name_choice.strip == "n" || page_name_choice.strip ==  "N"
        puts("Enter File Name")
        puts("Example: for html.erb file type only file name home not home.html.erb")
        file_name = SharedMethod.method(:gets_setting).call
        result= !(SharedMethod.method(:test_env?).call )? (!File.read("config/routes.rb").include?(%Q(get "#{"static" + '/' + file_name.strip}" => "static##{file_name.strip}"))) : true
        if !check_formet(file_name.strip)  && result
        else
          puts("file_name should not contain numeric at start or already register route with this action")
          method(__method__).call(page_name) if !SharedMethod.method(:test_env?).call
        end
      else
        file_name = page_name.strip
      end
      if !(SharedMethod.method(:test_env?).call )? (!File.read("config/routes.rb").include?(%Q(get "#{"static" + '/' + file_name.strip}" => "static##{file_name.strip}"))) : true
        Action.new.new_file_manual_loc!("app/views/static",file_name.strip + ".html.erb") if !SharedMethod.method(:test_env?).call
        puts("Your File has been created as app/views/static/#{file_name.strip}.html.erb")
        define_routes("static",file_name) if !SharedMethod.method(:test_env?).call
      else
        puts("file_name already register with this route")
        method(__method__).call(page_name) if !SharedMethod.method(:test_env?).call
      end
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
    until line_layout.strip == "q"
      print("?- ")
      line_layout  = SharedMethod.method(:gets_setting).call
      case(line_layout.strip)
      when '1'
        if count == 0
          puts("You have selected common Header and Footer")
          common_header_footer if !SharedMethod.method(:test_env?).call
          count+= 1
          break
        else
        end
      when '2'
        if count == 0
          puts("You have selected common Header only")
          header_only  if !SharedMethod.method(:test_env?).call
          count+= 1
          break
        else
        end
      when '3'
        if count == 0
          puts("You have selected common Footer only")
          footer_only  if !SharedMethod.method(:test_env?).call
          count+= 1
          break
        else
        end
      when '4'
        puts("Additional function come in future")
        method(__method__).call  if !SharedMethod.method(:test_env?).call
        break
      else
        puts("Please enter your choice in these option only.")
        method(__method__).call if !SharedMethod.method(:test_env?).call
        break
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
      Action.new.insert_into_file!("before","app/views/layouts/application.html.erb"," <%= render 'shared/header' %>","\n<%= yield%>")
      Action.new.append_file!("app/assets/stylesheets/order_me_application.css.scss","@import 'header';")
    else
      Action.new.insert_into_file!("after","app/views/layouts/application.html.erb","\n <%= render 'shared/footer' %>","<%= yield %>")
      Action.new.append_file!("app/assets/stylesheets/order_me_application.css.scss","\n @import 'footer';")
    end
    if js_file != nil
      Action.new.new_file!(js_file,"#{category}.js","assets/javascripts")
    else
    end
  end

  def api_fetch(key)
    template = ApiCall.template_search(key)
    if template.last == "true"
      html_file = "#{WEB_URL}/template/#{template.first["template"]["file"]}"
      css_file = "#{WEB_URL}/template/#{template.first["template"]["css_file"]}"
      if template.first["template"]["js_file"] != nil
        js_file = "#{WEB_URL}/template/#{template.first["template"]["js_file"]}"
        return html_file,css_file,js_file
      else
        return html_file,css_file
      end
    else
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
    if a.last =="true"
      puts("Enter Your Choice about Header")
      puts("click on link to preview the header")
      puts("1.header first #{"#{WEB_URL}templates/#{a.first["template"].first["id"]}"}")
      puts("2.header second #{"#{WEB_URL}templates/#{a.first["template"][1]["id"]}"}")
      puts("3 header third #{"#{WEB_URL}templates/#{a.first["template"][2]["id"]}"}")
      puts("4. View More #{"#{WEB_URL}templates/"}")
      choice = SharedMethod.method(:gets_setting).call
      if choice.to_i > 4
        header_list
      elsif choice.to_i == 0
        puts("please select choice define above only.")
        header_list
      else
        hader = {}
        hader = a.first["template"][(choice.to_i - 1)]["key"]
        return choice,hader
      end
    end
  end

  def header_view_more
    puts("Enter Your key to apply that Header")
    key = SharedMethod.method(:gets_setting).call
  end
  def footer_view_more
    puts("Enter Your key to apply that Footer")
    key = SharedMethod.method(:gets_setting).call
  end

  def footer_list
    a= ApiCall.footer_list
    if a.last == "true"
      puts("Enter Your Choice about Footer")
      puts("click on link to preview the Footer")
      puts("1.Footer first #{"#{WEB_URL}templates/#{a.first["template"].first["id"]}"}")
      puts("2.Footer second #{"#{WEB_URL}templates/#{a.first["template"][1]["id"]}"}")
      puts("3 Footer third #{"#{WEB_URL}templates/#{a.first["template"][2]["id"]}"}")
      puts("4. View More #{"#{WEB_URL}templates/"}")
      choice = SharedMethod.method(:gets_setting).call
      if choice.to_i > 4
        footer_list
      elsif choice.to_i == 0
        puts("please select choice define above only.")
        footer_list
      else
        foter = {}
        foter = a.first["template"][(choice.to_i - 1)]["key"]
        return choice,foter
      end
    else
    end
  end
end
