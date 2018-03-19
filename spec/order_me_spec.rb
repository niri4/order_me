Dir["./spec/support/shared_examples/*.rb"].each {|file| require file }


RSpec.describe OrderMe do
  it "has a version number" do
    expect(OrderMe::VERSION).not_to be nil
  end

  describe "Choice about the above Manually or Speaking  and for quit Selection" do
    before do
      module SharedMethod
          def self.gets_setting
            $val
          end
      end

      class PagesDescription
        def self.pages_select
        end
      end
    end
    describe "your choice about selection" do
      before do
        $val = 'q'
      end
      it "Selected to quit on ctrl+c and q" do
        begin
         expect{OrderMe::Action.install}.to output(%Q(Hello, Welcome to Order Me Hold Tight For Reveolution.\nEnter Your Choices\n1. Manually\n2. Speaking\nEnter Q  or ctrl + c to Quit\n?- GraceFully Shutting Down\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "ask about your choice about selection" do
      before do
        $val = '1'
      end
      it "Selected as Manually" do
        begin
          expect{OrderMe::Action.install}.to output(%Q(Hello, Welcome to Order Me Hold Tight For Reveolution.\nEnter Your Choices\n1. Manually\n2. Speaking\nEnter Q  or ctrl + c to Quit\n?- Your Choice is selected as Manually.\nYou Need To Tell Us\nHow many pages you want in app\n1. one page\n2. two pages\n3. three pages\n4. Define Yourself\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end

    describe "ask about your choice about selection" do
      before do
        $val = '2'
      end
      it "Selected as Speaking" do
        begin
          expect{OrderMe::Action.install}.to output(%Q(Hello, Welcome to Order Me Hold Tight For Reveolution.\nEnter Your Choices\n1. Manually\n2. Speaking\nEnter Q  or ctrl + c to Quit\n?- Your Choice is Selected as Speaking.\nsoonly coming\n)).to_stdout
       rescue SystemExit => e
       end
      end
    end


  end
end
