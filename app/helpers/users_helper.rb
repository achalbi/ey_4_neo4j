module UsersHelper

  def create_fb_friends(uid, friends)
        friends.each do |friend|
          FbWorker.perform_async(uid, friend['id'], friend['name'])
        end
  end


    def update_with_omniauth(user, auth)
        user_details = auth['extra']['raw_info']
        user.uid = auth["uid"]
        user.name = auth["info"]["name"]
        user.fb_access_token = auth['credentials']['token']
        user.username = auth['info']['nickname']
        user.email = user_details['email']
        user.gender = user_details['gender']
        #user.dob = DateTime.parse(user_details['birthday'])
        user.remember_token = SecureRandom.urlsafe_base64
        user.save!
    #UserMailer.welcome_email(user).deliver
        return user
    end

end
