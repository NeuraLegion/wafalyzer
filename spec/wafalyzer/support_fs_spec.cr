require "../spec_helper"

Spectator.describe Wafalyzer::SupportFS do
  subject { Wafalyzer::SupportFS }

  describe ".payloads" do
    subject { Wafalyzer::SupportFS.payloads }

    it "returns an non-empty array of strings" do
      is_expected.to be_a(Array(String))
      is_expected.to_not be_empty
    end
  end

  describe ".user_agents" do
    subject { Wafalyzer::SupportFS.user_agents }

    it "returns an non-empty array of strings" do
      is_expected.to be_a(Array(String))
      is_expected.to_not be_empty
    end
  end
end
