# require 'spec_helper'
# 
# describe "Static pages" do
#   subject { page }
# 
#   describe "Home page" do
#     before { visit root_path } 
#     it { should have_selector('h1', text: 'Notable') }
#     it { should have_selector('a#logo', text: '0.2')}
#     it { should_not have_selector('title', text: " | Home") }
#   end
# 
# 
#     describe "for signed-in users" do
#       let(:user) { FactoryGirl.create(:user) }
#       before do
#         FactoryGirl.create(:note, user: user, content: "Lorem ipsum")
#         FactoryGirl.create(:note, user: user, content: "Dolor sit amet")
#         sign_in user
#         visit root_path
#       end
# 
#       it "should render the user's notebook" do
#         user.notes.each do |item|
#           page.should have_selector("li##{item.id}", text: item.content)
#         end
#       end
# 
#       describe "Settings page" do
#         before { visit settings_path } 
#         it { should have_selector('h1', text: 'Settings') }
#         it { should have_selector('title', text: " | Settings") }
#       end
# 
#     end
# 
#   describe "Help page" do
#     before { visit help_path } 
#     it { should have_selector('h1', text: 'Help') }
#     it { should have_selector('title', text: " | Help") }
#   end
# 
#   describe "About page" do
#     before { visit about_path } 
#     it { should have_selector('h1', text: 'About') }
#     it { should have_selector('title', text: " | About") }
#   end
# 
#   describe "Contact page" do
#     before { visit contact_path } 
#     it { should have_selector('h1', text: 'Contact') }
#     it { should have_selector('title', text: " | Contact") }
#   end
# 
#   it "should have the right links on the layout" do
#     visit root_path
#     click_link "About"
#     should have_selector 'title', text: full_title('About Us')
#     click_link "Help"
#     should have_selector 'title', text: full_title('Help')
#     click_link "Contact"
#     should have_selector 'title', text: full_title('Contact')
#   end
# end
