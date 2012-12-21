require 'open-uri'
require 'nokogiri'

require 'craigslist/cities'
require 'craigslist/categories'
require 'craigslist/craigslist'

module Craigslist
  PERSISTENT = Persistent.new

  class << self
    def cities
      CITIES.keys.sort
    end

    def categories
      arr = CATEGORIES.keys
      CATEGORIES.each do |key, value|
        if value['children']
          arr.concat(value['children'].keys)
        end
      end
      arr.sort
    end

    def city?(city)
      CITIES.keys.include?(city) ? true : false
    end

    def category?(category)
      return true if CATEGORIES.keys.include?(category)

      CATEGORIES.each do |key, value|
        if value['children']
          return true if value['children'].keys.include?(category)
        end
      end

      false
    end

    # Create city methods
    CITIES.each do |key, value|
      define_method(key.to_sym) do
        Craigslist::PERSISTENT.city = value
        self
      end
    end

    # Create category methods
    CATEGORIES.each do |key, value|
      if value['path']
        define_method(key.to_sym) do
          Craigslist::PERSISTENT.category = value['path']
          self
        end
      end

      if value['children']
        value['children'].each do |key, value|
          define_method(key.to_sym) do
            Craigslist::PERSISTENT.category = value
            self
          end
        end
      end
    end

    def build_uri(city_path, category_path)
      uri = "http://#{city_path}.craigslist.org/#{category_path}/"
    end

    def last(max_results=20)
      raise StandardError, "city and category must be part of the method chain" unless
        Craigslist::PERSISTENT.city && Craigslist::PERSISTENT.category

      uri = self.build_uri(Craigslist::PERSISTENT.city, Craigslist::PERSISTENT.category)
      doc = Nokogiri::HTML(open(uri))

      count = 0
      arr = []
      doc.xpath("//p[@class = 'row']").each do |node|
        h = {}

        inner = Nokogiri::HTML(node.to_s)
        i = 0
        inner.xpath("//a").each do |inner_node|
          if i % 2 == 0
            h['text'] = inner_node.text.strip
            h['href'] = inner_node['href']
          end
          i += 1
        end

        inner.xpath("//span[@class = 'itempp']").each do |inner_node|
          h['price'] = inner_node.text.strip
        end

        inner.xpath("//span[@class = 'itempn']/font").each do |inner_node|
          h['location'] = inner_node.text.strip[1..(inner_node.text.strip.length - 2)].strip
        end

        inner.xpath("//span[@class = 'itempx']/span[@class = 'p']").each do |inner_node|
          h['has_img'] = inner_node.text.include?('img') ? true : false 
          h['has_pic'] = inner_node.text.include?('pic') ? true : false
        end

        count += 1
        arr << h
        break if count == max_results
      end
      arr
    end

    alias_method :posts, :last

    def method_missing(name, *args, &block)
      if name =~ /^last_(\d*)$/
        self.send(:last, /^last_(\d*)$/.match(name)[1].to_i)
      else
        super
      end
    end
  end
end
