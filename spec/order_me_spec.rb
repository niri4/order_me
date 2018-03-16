RSpec.describe OrderMe do
  it "has a version number" do
    expect(OrderMe::VERSION).not_to be nil
  end

  context "ask about your choice about selection" do
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
    it "Selected as manually" do
      expect(OrderMe::Action.install).to eq("Your Choice is selected as Manually.")
    end
  end
end
