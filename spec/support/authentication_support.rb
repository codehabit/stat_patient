  def sign_in_as(user, password)
    login_as(user, scope: :user)
    # password = 'sec5ret)one'
    # user ||= create(:user, password: password, password_confirmation: password)
    # visit new_user_session_path
    # fill_in 'Email', with: user.email
    # fill_in 'Password', with: password
    # click_button 'Sign in'
  end

  # useful later, no doubt
  # def sign_in_as_nobody
  #   ApplicationController.any_instance.stub(:current_user).and_return nil
  # end

  # def page_looks_unauthorized
  #   page.should have_content I18n.t(:not_authorized_message)
  # end

  # def page_looks_authorized
  #   page.should_not have_content I18n.t(:not_authorized_message)
  # end
