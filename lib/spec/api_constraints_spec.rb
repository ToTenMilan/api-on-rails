require 'spec_helper'

describe ApiConstraints do
  let(:api_constraints_v1) { ApiConstraints.new(version: 1) }
  let(:api_constraints_v2) { ApiConstraints.new(version: 2, default: true) }

  describe "#matches?" do
    it "returns true when the version matches the 'Accept' header" do
      request = double(host: 'api.marketplace.dev',
                        headers: {"Accept" => "application/vnd.marketplace.v1" } ) # this string needs to match the one specified as an argument to `include?` in `lib/api_constraints.rb` for method `matches?` to evaluate to true as expected by spec
      # api_constraints_v1.matches?(request).should be_true # deprecated, :expect used instead
      expect(api_constraints_v1.matches?(request)).to be true

    end

    it "returns the default version when the 'default' option is specified" do
      request = double(host: 'api.marketplace.dev')
      # api_constraints_v2.matches?(request).should be_true # deprecated, :expect used instead
      expect(api_constraints_v2.matches?(request)).to be true # option `default: true` is provided by setup in `let` so this will evaluate to true as expected by spec
    end
  end
end
