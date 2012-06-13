require 'spec_helper'

describe EY::CloudClient::AppEnvironment do
  before(:each) do
    FakeWeb.allow_net_connect = true
  end

  describe "deploying" do
    before do
      @api = scenario_cloud_client "Multiple Ambiguous Accounts"
      result = EY::CloudClient::AppEnvironment.resolve(@api, 'app_name' => 'rails232app', 'environment_name' => 'giblets', 'account_name' => 'main')
      result.should be_one_match
      @app_env = result.matches.first
    end

    it "creates a deployment" do
      deployment = @app_env.new_deployment({
        :ref             => 'master',
        :migrate         => true,
        :migrate_command => 'rake migrate',
        :extra_config    => {'extra' => 'config'},
      })
      deployment.commit.should be_nil
      deployment.resolved_ref.should be_nil

      deployment.created_at.should be_nil
      deployment.finished_at.should be_nil

      deployment.start

      deployment.created_at.should_not be_nil
      deployment.finished_at.should be_nil
      deployment.config.should == {'deployed_by' => 'Multiple Ambiguous Accounts', 'extra' => 'config'}
      deployment.commit.should =~ /[0-9a-f]{40}/
      deployment.resolved_ref.should_not be_nil
      deployment.out << "Test output"
      deployment.out << "Test error"
      deployment.successful = true
      deployment.finished
      deployment.should be_finished
      deployment.created_at.should be_within(5).of(Time.now)
      deployment.finished_at.should be_within(5).of(Time.now)

      found_dep = @app_env.last_deployment
      found_dep.id.should == deployment.id
      found_dep.should be_finished
    end

    it "returns nil when a not found deployment is requested" do
      EY::CloudClient::Deployment.get(@api, @app_env, 0).should be_nil
    end
  end
end
