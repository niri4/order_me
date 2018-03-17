RSpec.describe PagesDescription do

  describe "Selection about Page Choice" do
    describe "page choice as single page App" do
      before do
        class PagesDescription
          def page_heading page_count
          end
        end
        module SharedMethod
          def self.gets_setting
             '1'
          end
        end
      end
      it "Select as choice one page" do
        begin
          allow(PagesDescription.new.pages_select).to receive_messages(["1. one page app selected "])
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
          allow(PagesDescription.new.pages_select).to receive_messages(["2. Two page app selected "])
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
          allow(PagesDescription.new.pages_select).to receive_messages(["3. Three page app selected "])
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
          allow(PagesDescription.new.pages_select).to receive_messages(["3. Three page app selected "])
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
          allow(PagesDescription.new.pages_select).to receive_messages(["4. According to your request pages select 4"])
       rescue SystemExit => e
       end
      end
    end
  end
end
