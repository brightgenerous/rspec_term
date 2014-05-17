# encoding: utf-8
require File.expand_path(File.join('../', 'spec_helper'), File.dirname(__FILE__))

describe "RSpecTerm Failure Pleasure" do

  it do
    sleep rand(10) + 5;
    expect(true).to be false
  end

end

