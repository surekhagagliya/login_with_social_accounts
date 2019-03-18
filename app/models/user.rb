class User < ActiveRecord::Base
  devise :rememberable, :trackable, :omniauthable,
         :omniauth_providers => [:twitter, :facebook, :linkedin, :google_oauth2, :github, 
                                :pinterest, :instagram, 
                                 *(:developer if Rails.env.development?)]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
    end
  end
end