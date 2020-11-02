class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  def self.find_for_facebook(auth_hash)
    user = User.where(:email => auth_hash.info["email"]).first

    unless user
      user = User.create(
          fullname: auth_hash.info["name"],
          email: auth_hash.info["email"],
          image: auth_hash.info['image'],
          password: Devise.friendly_token[0,20]
          )
    end
    user.provider = auth_hash["provider"]
    user.uid = auth_hash["uid"]
    user
  end


end

