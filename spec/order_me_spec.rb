RSpec.describe OrderMe do
  it "has a version number" do
    expect(OrderMe::VERSION).not_to be nil
  end

  describe "ask about your choice about selection" do

    before do
      module SharedMethod
        def self.gets_setting
          '1'
        end
      end

      class PagesDescription
        def pages_select
        end
      end
    end

    it "Selected as Manually" do
      begin
       expect(OrderMe::Action.install).to eq("Your Choice is selected as Manually.")
     rescue SystemExit => e
     end
    end
  end
end
