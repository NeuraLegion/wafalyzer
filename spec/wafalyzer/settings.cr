require "../spec_helper"

Spectator.describe Wafalyzer::Settings do
  subject { Wafalyzer::Settings }

  def with_random_user_agent(value)
    prev_value = subject.use_random_user_agent?
    begin
      subject.use_random_user_agent = value
      yield
    ensure
      subject.use_random_user_agent = prev_value
    end
  end

  describe ".default_user_agent" do
    subject { Wafalyzer::Settings.default_user_agent }

    it "returns a string with 'wafalyzer' in it" do
      is_expected.to contain("wafalyzer")
    end
  end

  describe ".user_agents" do
    subject { Wafalyzer::Settings.user_agents }

    it "returns an non-empty array of strings" do
      is_expected.to be_a(Array(String))
      is_expected.to_not be_empty
    end
  end

  describe ".user_agent" do
    context "with use_random_user_agent = false" do
      around_each do |proc|
        with_random_user_agent(false) { proc.call }
      end

      it "returns .default_user_agent string" do
        expect(&.user_agent).to eq(subject.default_user_agent)
      end
    end

    context "with use_random_user_agent = true" do
      around_each do |proc|
        with_random_user_agent(true) { proc.call }
      end

      it "returns random user agent string" do
        expect(&.user_agent).to_not eq(subject.default_user_agent)
      end
    end
  end
end
