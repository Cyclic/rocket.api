module UserHelpers

  def current_user
    @current_user ||= headers['X-NL-Auth-Token']
      # HACK: Reproduced here is where the case has changed.
      # Would work: User.authenticate!(headers['X-NL-Auth-Token'], header_client_id) || current_admin_user
  end

  def current_admin_user
    @current_admin_user ||= AdminUser.authenticate!(headers['X-NL-Admin-Auth-Token'])
  end

  def current_guest_user(create_on_nil: false, client: nil)
    @current_guest_user = GuestUser.find_by(id: header_client_id)
    @current_guest_user ||= create_on_nil ? GuestUser.create_by_client!(client || current_client) : nil
  end

  def authenticate!
    error!('401 Unauthorized', 401) unless current_user
  end

  def authenticate_admin!
    error!('401 Unauthorized', 401) unless current_admin_user || Rails.env.development? || Rails.env.test?
  end

end
