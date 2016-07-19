def consolidate_cart(cart)
  cart_hash = {}
  cart.each_with_index do |x, i|
    x.each do |k1, v1|
      if !cart_hash.has_key?(k1)
        cart_hash[k1] = v1
        cart_hash[k1][:count] = 0
      end
      if cart_hash.has_key?(k1)
        cart_hash[k1][:count] += 1
      end
    end
  end
cart = cart_hash
cart
end

def apply_coupons(cart, coupons)
new_cart_hash = cart.clone
  coupons.each do |x|
  if new_cart_hash.keys.include?(x[:item]) && new_cart_hash[x[:item]][:count] >= x[:num]
     new_cart_hash[x[:item]][:count] = new_cart_hash[x[:item]][:count] - x[:num]
    if new_cart_hash.keys.include?("#{x[:item]} W/COUPON")
       new_cart_hash["#{x[:item]} W/COUPON"][:count] += 1
    else new_cart_hash["#{x[:item]} W/COUPON"] = {price: x[:cost], clearance: cart[x[:item]][:clearance], count: 1}
    end
  end
end
cart = new_cart_hash
cart
end

def apply_clearance(cart)
  cart.collect do |k1, v1|
    if v1[:clearance] == true
      v1[:price] = (v1[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cm_price = 0
  cart.each do |k1, v1|
  cm_price += (v1[:price] * v1[:count])
  end
  if cm_price >= 100
  cm_price = (cm_price * 0.9).round(2)
  end
  cm_price
end
