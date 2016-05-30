require "rails_helper"
RSpec.describe "creating a user" do
  before do
    visit "users/new"
  end
  it "creates new user and redirects to profile page with proper credentials" do
    fill_in "Email", with: "solly@gmail.com"
    fill_in "Name", with: "solly"
    fill_in "user_password", with: "solly0702", exact: true
    fill_in "user_password_confirmation", with: "solly0702", exact: true
    click_button "Join"
    last_user = User.last
    expect(current_path).to eq("/users/#{last_user.id}")
  end
  it "shows valiation errors without proper credentials" do
    click_button "Join"
    expect(current_path).to eq("/users/new")
    expect(page).to have_text("can't be blank")
    expect(page).to have_text("invalid")
  end
end
