module Features
  def sigin_in_as_admin(options={})
    visit "/admin"
    fill_in "Email", with: options[:email]
    fill_in "Password", with: options[:password]
    click_on "Login"
  end
end