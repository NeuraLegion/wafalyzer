require "../spec_helper"

Spectator.describe Wafalyzer::Waf do
  subject { Wafalyzer::Waf::ToughWaf.new }

  describe "#product" do
    it "returns an non-empty string" do
      expect(&.product).to be_a(String)
      expect(&.product).to_not be_empty
    end
  end

  describe "#matches?" do
    context "with matching value" do
      let(response1) do
        HTTP::Client::Response.new(
          status: :ok,
          headers: HTTP::Headers{"Set-Cookie" => "__tough_id=foo"}
        )
      end
      let(response2) do
        HTTP::Client::Response.new(
          status: :ok,
          body: "!you are very naughty visitor!"
        )
      end

      it "returns true" do
        expect(&.matches?(response1)).to be_true
        expect(&.matches?(response2)).to be_true
      end
    end

    context "with non-matching value" do
      let(response1) do
        HTTP::Client::Response.new(
          status: :ok,
          headers: HTTP::Headers{"Set-Cookie" => "__session_id=foo"},
        )
      end
      let(response2) do
        HTTP::Client::Response.new(
          status: :ok,
          body: "very naughty"
        )
      end

      it "returns false" do
        expect(&.matches?(response1)).to be_false
        expect(&.matches?(response2)).to be_false
      end
    end

    context "with matching status" do
      subject { Wafalyzer::Waf::SuperToughWaf.new }

      let(response) do
        HTTP::Client::Response.new(
          status: :forbidden,
          headers: HTTP::Headers{"Set-Cookie" => "__s0m00cht0ugh=foo"}
        )
      end

      it "returns true" do
        expect(&.matches?(response)).to be_true
      end
    end

    context "with non-matching status" do
      subject { Wafalyzer::Waf::SuperToughWaf.new }

      let(response) do
        HTTP::Client::Response.new(
          status: :no_content,
          headers: HTTP::Headers{"Set-Cookie" => "__s0m00cht0ugh=foo"}
        )
      end

      it "returns false" do
        expect(&.matches?(response)).to be_false
      end
    end
  end
end
