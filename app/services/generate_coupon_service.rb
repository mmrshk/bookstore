class GenerateCouponService
  class << self
    def generate
      loop do
        coupon = Array.new(10) { rand(1...10) }.join

        return coupon if Coupon.where(coupon: coupon).empty?
      end
    end
  end
end
