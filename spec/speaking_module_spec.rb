RSpec.describe OrderMe do

  describe "ask about your choice about selection" do
    before do
      module SharedMethod
        def self.gets_setting
          '2'
        end
      end
    end
    it "Selected as Speaking" do
      begin
       expect(  OrderMe::Action.install).to eq("Your Choice is Selected as Speaking.")
     rescue SystemExit => e
     end
    end
  end
end
