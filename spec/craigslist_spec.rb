require 'craigslist'

describe "Craigslist" do
  context "#cites" do
    it "should return an Array of cities" do
      cities = Craigslist.cities
      cities.should be_a Array
      cities.length.should be > 10
    end
  end

  context "#categories" do
    it "should return an Array of categories" do
      categories = Craigslist.categories
      categories.should be_a Array
      categories.length.should be > 5
    end
  end

  context "#city?" do
    it "should return true for a city that exists" do
      Craigslist.city?('seattle').should be true
    end

    it "should return false for a category that does not exist" do
      Craigslist.city?('asfssdf').should be false
    end
  end

  context "#category?" do
    it "should return true for a category that exists" do
      Craigslist.category?('for_sale').should be true
      Craigslist.category?('travel_vac').should be true
    end

    it "should return false for a category that does not exist" do
      Craigslist.category?('assdfaff').should be false
    end
  end

  context "#build_uri" do
    it "should return a valid uri" do
      Craigslist.build_uri('seattle', 'jjj').should eq "http://seattle.craigslist.org/jjj/"
    end
  end

  context "a city method" do
    it "should return a Craigslist:Module object so that method calls can be
      chained" do
      Craigslist.seattle.should be_a Module
    end
  end

  context "a category method" do
    it "should return a Craigslist:Module object so that method calls can be
      chained" do
      Craigslist.for_sale.should be_a Module
    end
  end

  context "#last" do
    it "should return the default number of last posts for seattle and
      for_sale" do
      posts = Craigslist.seattle.for_sale.last
      posts.should be_a Array
      posts.length.should eq 20
    end

    it "should return a specific number of last posts for seattle and
      for_sale" do
      max_results = 2
      posts = Craigslist.seattle.for_sale.last(max_results)
      posts.should be_a Array
      posts.length.should eq max_results
    end

    it "should return a specific number of last posts for seattle and for_sale
      using a dynamic finder method" do
      max_results = 2
      posts = Craigslist.seattle.for_sale.send(("last_" + max_results.to_s).to_sym)
      posts.should be_a Array
      posts.length.should eq max_results
    end
  end

  context "#posts" do
    it "should return the default number of last posts for seattle and
      for_sale since #posts is an alias of #last" do
      posts = Craigslist.seattle.for_sale.posts
      posts.should be_a Array
      posts.length.should eq 20
    end
  end
end
