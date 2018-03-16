RSpec.describe OrderMe do
  it "has a version number" do
    expect(OrderMe::VERSION).not_to be nil
  end

  context "ask about your choice about selection" do
    before(:all) do

      end
    it "Selected as manually" do
      # name = $stdin.gets
      obj =double(OrderMe::Action.install)
      # expect(OrderMe::Action.install).to receive(:gets).with(name)
      allow(obj).to receive(:gets) { "1" }
      #.with("Your Choice is selected as Manually.")
    #  expect(name).to eq("Your Choice is selected as Manually.")
    end
  end
end
