# encoding: utf-8
require File.expand_path(File.join('../', 'spec_helper'), File.dirname(__FILE__))

describe RSpecTerm do

  describe RSpecTerm::Configure do
    it "arguments" do
      expect{ RSpecTerm::Configure.new }.to raise_error
      expect(RSpecTerm::Configure.instance).not_to be_nil
      expect(RSpecTerm.configure).to be RSpecTerm::Configure.instance
      methods = [
                  :success_file, :success_file=,
                  :success_url,  :success_url=,
                  :running_file, :running_file=,
                  :running_url,  :running_url=,
                  :failure_file, :failure_file=,
                  :failure_url,  :failure_url=,
                  :nothing_file, :nothing_file=,
                  :nothing_url,  :nothing_url=,
                  :tmp_dir,      :tmp_dir=,
                  :process,      :process=
                ]
      expect(methods - RSpecTerm::Configure.instance_methods).to eq []
      expect(methods - RSpecTerm.configure.methods).to eq []
    end
  end

  describe RSpecTerm::Formatters::BackgroundFormatter do
    it "`init` method" do
      methods = [
                  :start, :dump_summary
                ]
      expect(methods - RSpecTerm::Formatters::BackgroundFormatter.instance_methods).to eq []
    end
  end
end

