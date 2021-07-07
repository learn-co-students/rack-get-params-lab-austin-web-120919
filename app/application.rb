  require 'pry'
  
  class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []
  binding.pry

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
        binding.pry
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
      binding.pry

    elsif req.path.match(/cart/)
      if @@cart.length > 0 
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      elsif @@cart.length == 0
        resp.write "Your cart is empty"
      end
    elsif req.path.match(/add/)
      add_item = req.GET["item"]
        if @@items.include?(item_to_add)
             @@cart << item_to_add
            resp.write "added #{item_to_add}"        
      else
        resp.write "We don't have that item"
      binding.pry
      end
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end


  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
