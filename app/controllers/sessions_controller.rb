class SessionsController < ApplicationController

  def create
    @user = begin
      uid = auth_hash['uid']
      Player.find_by_yammer_uid(uid) ||
        Player.create name: auth_hash['info']['name'],
                      yammer_props: { yammer_uid: uid }
    end
    self.current_user = @user
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
