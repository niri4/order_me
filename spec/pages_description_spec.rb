require "./lib/pages_description"
RSpec.describe PagesDescription do

  describe "Selection about Page Choice" do

    before do
      module SharedMethod
        def self.gets_setting
           $val
        end
        def self.test_env?
           true
        end
      end
    end

    describe "page choice as single page App" do
      before do
        $val = '1'
      end
      it "Select as choice one page" do
        begin
          expect{PagesDescription.new.pages_select}.to output(%Q(?- 1. one page app selected \n)).to_stdout
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
          expect{PagesDescription.new.pages_select}.to output(%Q(?- 2. Two page app selected\n)).to_stdout
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
          expect{PagesDescription.new.pages_select}.to output(%Q(?- 3. Three page app selected \n)).to_stdout
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
          expect{PagesDescription.new.pages_select}.to output(%Q(?- 4. Define Yourself choice selected\nAceept only numeric values\nenter the pages\n4. According to your request pages select 4\n)).to_stdout
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
          expect{PagesDescription.new.pages_select}.to output(%Q(?- 4. Define Yourself choice selected\nAceept only numeric values\nenter the pages\n4. According to your request pages select 4\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end
  end

  describe "tell us page heading of all pages selected" do
    before do
      module SharedMethod
        def self.gets_setting
           $val
        end
        def self.test_env?
           true
        end
      end
    end

    describe "must be comma seprated" do
      before do
        $val = 'home'
      end
      it "must be a comma seprated" do
        begin
          expect{PagesDescription.new.page_heading(1)}.to output(%Q(Enter Pages headings\nplaese make sure write with comma seprated eg home,about us,contact us.\nWant to set root (y/enter)\nRoot remain unchanged\nyou Have selected 1 pages,pages name is home\n)).to_stdout
       rescue SystemExit => e
       end
      end

    end
    describe "must be invalid if not comma seprated" do
      before do
        $val = 'csdfvs sdfsgs'
      end
      it "must be a invalid if not comma seprated" do
        begin
          expect{PagesDescription.new.page_heading(2)}.to output(%Q(Enter Pages headings\nplaese make sure write with comma seprated eg home,about us,contact us.\nPlease Enter the pages correctly\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "must not have any numeric character at start" do
      before do
        $val = '1fsef'
      end
      it "must be a invalid if have any numeric character at start" do
        begin
          expect{PagesDescription.new.page_heading(1)}.to output(%Q(Enter Pages headings\nplaese make sure write with comma seprated eg home,about us,contact us.\npage heading should not contain numeric at start\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "must have same number of heading as page selected" do
      before do
        $val = 'fsef'
      end
      it "must have same number of heading as page selected" do
        begin
          expect{PagesDescription.new.page_heading(2)}.to output(%Q(Enter Pages headings\nplaese make sure write with comma seprated eg home,about us,contact us.\nPlease Enter the pages correctly\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

  end

  describe "Choice about selection of file storage" do
    before do
      module SharedMethod
        def self.gets_setting
           $val
        end
        def self.test_env?
           true
        end
      end
    end

    describe "selection about storage_type as a Directory" do
      before do
        $val = '1'
      end
      it "should not conatain numeric in it" do
        begin
          expect{PagesDescription.new.want_directory?('home')}.to output(%Q(Your selected choice is directory\nwant to revert your decision (y/n)\nEnter Directory name\ndirectory_name should not contain numeric at start\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "selection about storage_type as a Directory" do
      before do
        $val = ''
      end
      it "should be invalid if selected as nil" do
        begin
          expect{PagesDescription.new.want_directory?('home')}.to output(%Q(Your selected choice is directory\nwant to revert your decision (y/n)\nEnter Directory name\nDirectory Name cannot be empty.\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "selection about storage_type as a Directory" do
      before do
        $val = 'home'
      end
      it "should be pass and create file" do
        begin
          expect{PagesDescription.new.want_directory?('home')}.to output(%Q(Your selected choice is directory\nwant to revert your decision (y/n)\nEnter Directory name\nEnter file location\nNOTE: Enter location in between your app by default app/views\nExample: app/views\nby default file_name is home want to change press N or n\nYour File has been created as home/home/home.html.erb\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "selection about storage_type as a Directory" do
      before do
        $val = 'y'
      end
      it "should be revert back to select choice about storage type" do
        begin
          expect{PagesDescription.new.want_directory?('home')}.to output(%Q(Your selected choice is directory\nwant to revert your decision (y/n)\nYour choice select as Directory would be revert back select again your choice.\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "selection about storage_type as a Directory" do
      before do
        $val = 'n'
      end
      it "should be overirde file name as via press the n button" do
        begin
          expect{PagesDescription.new.want_directory?('home')}.to output(%Q(Your selected choice is directory\nwant to revert your decision (y/n)\nEnter Directory name\nEnter file location\nNOTE: Enter location in between your app by default app/views\nExample: app/views\nby default file_name is home want to change press N or n\nEnter your File Name\nExample: for html.erb file type only file name home not home.html.erb\nYour File has been created as n/n/n.html.erb\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "selection about storage_type as a single storage" do
      before do
        $val = 'y'
      end
      it "should be revert back to select choice about storage type" do
        begin
          expect{PagesDescription.new.want_file_store?('home')}.to output(%Q(Your Selected Choice is file at single storage\nwant to revert your decision (y/n)\nYour choice select as single storage would be revert back select again your choice.\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "selection about storage_type as a single storage" do
      before do
        $val = 'n'
      end
      it "should be overirde file name as via press the n button" do
        begin
          expect{PagesDescription.new.want_file_store?('home')}.to output(%Q(Your Selected Choice is file at single storage\nwant to revert your decision (y/n)\nby default file_name is home want to change press N or n\nEnter File Name\nExample: for html.erb file type only file name home not home.html.erb\nYour File has been created as app/views/static/n.html.erb\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "selection about storage_type as a single storage" do
      before do
        $val = 'home'
      end
      it "should be pass and create file" do
        begin
          expect{PagesDescription.new.want_file_store?('home')}.to output(%Q(Your Selected Choice is file at single storage\nwant to revert your decision (y/n)\nby default file_name is home want to change press N or n\nYour File has been created as app/views/static/home.html.erb\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

  end

  describe "Selection about Layout Choice" do
    before do
      module SharedMethod
        def self.gets_setting
           $val
        end
        def self.test_env?
           true
        end
      end
    end
    describe "selected as Common Header and Footer" do
      before do
        $val = '1'
      end
      it "should have selected common header and footer if choice 1" do
        expect{PagesDescription.new.layout_choice}.to output(%Q(Enter Your choice about layout\n1. Want Common Header And Footer\n2. Header Only\n3. Footer Only\n4. Make Seprate Header and Footer for every Pages\n?- You have selected common Header and Footer\n)).to_stdout
      end
    end

    describe "selected as Header only if choice 2" do
      before do
        $val = '2'
      end
      it "should have selected only Header" do
        expect{PagesDescription.new.layout_choice}.to output(%Q(Enter Your choice about layout\n1. Want Common Header And Footer\n2. Header Only\n3. Footer Only\n4. Make Seprate Header and Footer for every Pages\n?- You have selected common Header only\n)).to_stdout
      end
    end

    describe "selected as Footer only if choice 3" do
      before do
        $val = '3'
      end
      it "should have selected only Footer" do
        expect{PagesDescription.new.layout_choice}.to output(%Q(Enter Your choice about layout\n1. Want Common Header And Footer\n2. Header Only\n3. Footer Only\n4. Make Seprate Header and Footer for every Pages\n?- You have selected common Footer only\n)).to_stdout
      end
    end

    describe "selected as Seprate Header and Footer for every Pages if choice 4" do
      before do
        $val = '4'
      end
      it "should Make Seprate Header and Footer for every Pages" do
        expect{PagesDescription.new.layout_choice}.to output(%Q(Enter Your choice about layout\n1. Want Common Header And Footer\n2. Header Only\n3. Footer Only\n4. Make Seprate Header and Footer for every Pages\n?- Additional function come in future\n)).to_stdout
      end
    end

    describe "selected as invalid choice" do
      before do
        $val = '5'
      end
      it "should not select as invalid choice" do
        expect{PagesDescription.new.layout_choice}.to output(%Q(Enter Your choice about layout\n1. Want Common Header And Footer\n2. Header Only\n3. Footer Only\n4. Make Seprate Header and Footer for every Pages\n?- Please enter your choice in these option only.\n)).to_stdout
      end
    end

  end

end
