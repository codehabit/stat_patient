  def sign_in_as user
    login_as(user, scope: :user)
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
