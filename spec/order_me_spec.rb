RSpec.describe OrderMe do
  it "has a version number" do
    expect(OrderMe::VERSION).not_to be nil
  end

  describe "Choice about the above Manually or Speaking Selection" do
    describe " your choice about selection" do
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
         expect(OrderMe::Action.install).to eq("Your Choice is Selected as Speaking.")
       rescue SystemExit => e
       end
      end
    end
    
  end
end
