module Craigslist
  class Persistent
    attr_accessor :city, :category

    def initialize
      @city = nil
      @category = nil
    end
  end
end
