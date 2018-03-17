RSpec.describe OrderMe do

  describe "ask about your choice about selection" do
    let(:abc){
      OrderMe::Action.install
    }
    before do
      module SharedMethod
        def self.gets_setting
          '2'
        end
      end
    end
    it "Selected as Speaking" do
      expect(abc).to eq("Your Choice is Selected as Speaking.")
    end
  end
end
