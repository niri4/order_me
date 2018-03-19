require "./lib/pages_description"
RSpec.describe PagesDescription do

  describe "Selection about Page Choice" do
    describe "page choice as single page App" do
      before do
        module SharedMethod
          def self.gets_setting
             '1'
          end
        class PagesDescription
          # def page_heading page_count
          # end
        end

        end
      end
      it "Select as choice one page" do
        begin
          expect{PagesDescription.pages_select}.to output(%Q()).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "page choice as two page" do
      before do
        class PagesDescription
          def page_heading page_count
          end
        end
        module SharedMethod
          def self.gets_setting
             '2'
          end
        end
      end
      it "Select as choice two page" do
        begin
          expect{PagesDescription.pages_select}.to output(%Q()).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "page choice as three page" do
      before do
        class PagesDescription
          def page_heading page_count
          end
        end
        module SharedMethod
          def self.gets_setting
             '3'
          end
        end
      end
      it "Select as choice three page" do
        begin
          expect{PagesDescription.pages_select}.to output(%Q()).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "page choice as by you define" do
      before do
        class PagesDescription
          def page_heading page_count
          end
        end
        module SharedMethod
          def self.gets_setting
             '4'
          end
        end
      end
      it "Select as choice by define ourself page" do
        begin
          expect{PagesDescription.pages_select}.to output(%Q()).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "page choice only be numeric" do
      before do
        class PagesDescription
          def page_heading page_count
          end
        end
        module SharedMethod
          def self.gets_setting
             '4'
          end
        end
      end
      it "Select as choice by define ourself page" do
        begin
          expect{PagesDescription.pages_select}.to output(%Q()).to_stdout
       rescue SystemExit => e
       end
      end
    end
  end
end
