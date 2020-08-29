require "./spec_helper"

Spectator.describe Wafalyzer do
  let(wafs) { subject.wafs }
  let(tough_waf) { wafs.find(&.class.==(Wafalyzer::Waf::ToughWaf)) }
  let(tough_waf_server) do
    HTTP::Server.new do |context|
      context.response
        .tap(&.content_type = "text/plain")
        .tap(&.print("!you are very naughty visitor!"))
        .close
    end
  end

  describe ".wafs" do
    it "return an array of all loaded Waf classes" do
      expect(wafs).to be_a(Array(Wafalyzer::Waf))
      expect(wafs).to_not be_empty
      expect(tough_waf).to_not be_nil
      expect(wafs).to contain(tough_waf)
    end
  end

  describe ".detect" do
    it "returns an array of detected Waf-s" do
      address = tough_waf_server.bind_unused_port
      run_server(tough_waf_server) do
        expect(&.detect("http://#{address}")).to eq([tough_waf])
      end
    end
  end

  describe ".detects?" do
    it "returns true when any waf is detected" do
      address = tough_waf_server.bind_unused_port
      run_server(tough_waf_server) do
        expect(&.detects?("http://#{address}")).to be_true
      end
    end
  end
end
