require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'EE5eciupJphQq7uhFRW3A', 'mytxNUX4870c7j2nRfUtCrTGdCoZ2DdcQGo2G7Ej1g'
  provider :open_id, OpenID::Store::Filesystem.new('/tmp')
  provider :openid, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end