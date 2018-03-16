RSpec.describe OrderMe do
  it "has a version number" do
    expect(OrderMe::VERSION).not_to be nil
  end

  context "ask about your choice about selection" do
    before do
      module OrderMe
        class Action
          def gets_setting
            "1"
          end
        end
      end
    end
    it "Selected as manually" do
      # name = $stdin.gets
      #obj =double(OrderMe::Action.install)
      # expect(OrderMe::Action.install).to receive(:gets).with(name)
      #allow(obj).to receive(:gets) { "1" }
      #OrderMe::Action.install.stub(:line).and_return(:return_value)
      OrderMe::Action.install.must_equal "Required action was test string."
      #.with("Your Choice is selected as Manually.")
    #  expect(name).to eq("Your Choice is selected as Manually.")
    end
  end
end
