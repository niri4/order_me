require "./lib/pages_description"
RSpec.describe PagesDescription do

  describe "Selection about Page Choice" do
    before do
      module SharedMethod
        def self.gets_setting
           $val
        end
      end
      class PagesDescription
        def self.pages_select
          pages = ""
          input_pages = ""
          page_line = ""
          count = 0
          until page_line.strip == "q"
            print("?- ")
            page_line  = SharedMethod.method(:gets_setting).call()
            begin
              case(page_line.strip)
              when '1'
                if count < 1
                puts("1. one page app selected ")
                # page_heading(1)
                end
                count= 1
                  pages += input_pages
                  break
              when '2'
                if count < 1
                  puts("2. Two page app selected")
                  # page_heading(2)
                  break
                end
                count= 1
                pages += input_pages
              when '3'
                if count < 1
                  puts("3. Three page app selected ")
                  # page_heading(3)
                  break
                end
                count =1
                  pages += input_pages
                when '4'
                  puts("4. Define Yourself choice selected")
                  puts("Aceept only numeric values")
                  puts("enter the pages")
                  value = SharedMethod.method(:gets_setting).call()
                  if value.to_i != 0
                    if count < 1
                      puts("4. According to your request pages select #{value.to_i}")
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
      end
    end
    describe "page choice as single page App" do
      before do
        $val = '1'
      end
      it "Select as choice one page" do
        begin
          expect{PagesDescription.pages_select}.to output(%Q(?- 1. one page app selected \n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "page choice as two page" do
      before do
        $val = '2'
      end
      it "Select as choice two page" do
        begin
          expect{PagesDescription.pages_select}.to output(%Q(?- 2. Two page app selected\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "page choice as three page" do
      before do
        $val = '3'
      end
      it "Select as choice three page" do
        begin
          expect{PagesDescription.pages_select}.to output(%Q(?- 3. Three page app selected \n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "page choice as by you define" do
      before do
        $val = '4'
      end
      it "Select as choice by define ourself page" do
        begin
          expect{PagesDescription.pages_select}.to output(%Q(?- 4. Define Yourself choice selected\nAceept only numeric values\nenter the pages\n4. According to your request pages select 4\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "page choice only be numeric" do
      before do
        $val = '4'
      end
      it "Select as choice by define ourself page" do
        begin
          expect{PagesDescription.pages_select}.to output(%Q(?- 4. Define Yourself choice selected\nAceept only numeric values\nenter the pages\n4. According to your request pages select 4\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end
  end
end
