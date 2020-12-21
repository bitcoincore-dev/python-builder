Rspec.describe "Gemfile" do
  it("has version constraint on every gem") do
    requirements = GemBench::StrictVersionRequirement.new({verbose: false})
    expect(requirements.list_missing_version_constraints).to eq([])
  end
end