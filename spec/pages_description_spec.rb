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

end
