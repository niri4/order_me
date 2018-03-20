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
end
