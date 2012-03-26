require 'spec_helper'

describe PagesController do
  render_views

  before(:each) do
    @baseTitle = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
                                    :content => @baseTitle + " | Home")
    end

    describe "for signed in users" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @mp1 = Factory(:micropost, :user => @user)
      end

      it "should show the right # of microposts" do
        get :home
        response.should have_selector("span.microposts", :content => "1 micropost")
      end

      it "should pluralize micropost count correctly" do
        @mp2 = Factory(:micropost, :user => @user)
        get :home
        response.should have_selector("span.microposts", :content => "2 microposts")
      end

      it "should paginate the microposts feed" do
        20.times do |n|
          Factory(:micropost, :user => @user, :content => "Post number #{n + 1}")
        end
        get :home
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a", :href => "/?page=2", :content => "2")
        response.should have_selector("a", :href => "/?page=2", :content => "Next")
      end
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title",
                                    :content => @baseTitle + " | Contact")
    end
  end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title",
                                    :content => @baseTitle + " | About")
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end

    it "should have the right title" do
      get 'help'
      response.should have_selector("title",
                                    :content => @baseTitle + " | Help")
    end
  end
end