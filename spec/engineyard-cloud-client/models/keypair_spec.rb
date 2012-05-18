require 'spec_helper'

describe EY::CloudClient::Keypair do
  describe ".all" do
    it "hits the index action in the API" do
      response = {
        "keypairs" => [
          {
            "fingerprint" => "11:f4:11:11:47:db:b7:3f:06:a9:XX:XX:XX:XX:XX:XX",
            "id" => 123,
            "name" => "macbook pro",
            "public_key" => "ssh-dss MYKEYPAIR"
          }
        ]
      }

      FakeWeb.register_uri(:get, "https://cloud.engineyard.com/api/v2/keypairs",
        :body => response.to_json, :content_type => "application/json")

      keypairs = EY::CloudClient::Keypair.all(cloud_client)

      keypairs.length.should == 1
      keypairs.first.name.should == "macbook pro"
    end
  end

  describe ".create" do
    it "hits the create action in the API" do
      response = {
        "keypair" => {
          "fingerprint" => "ce:90:99:b8:62:74:66:2f:ec:bc:XX:XX:XX:XX:XX:XX",
          "id" => 234,
          "name" => "laptop",
          "public_key" => "ssh-rsa OTHERKEYPAIR"
        }
      }

      FakeWeb.register_uri(:post, "https://cloud.engineyard.com/api/v2/keypairs",
        :body => response.to_json, :content_type => "application/json")

      keypair = EY::CloudClient::Keypair.create(cloud_client, {
        "name"       => 'laptop',
        "public_key" => "ssh-rsa OTHERKEYPAIR"
      })

      FakeWeb.should have_requested(:post, "https://cloud.engineyard.com/api/v2/keypairs")

      keypair.name.should == "laptop"
      keypair.public_key.should == "ssh-rsa OTHERKEYPAIR"
    end
  end

  describe "#destroy" do
    it "hits the destroy action in the API" do
      pending
    end
  end
end
