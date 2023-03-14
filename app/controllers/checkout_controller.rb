require 'uri'
require 'net/http'
require 'openssl'

class CheckoutController  < ApplicationController
  def create
    # debugger
    # @product = id
    @order = Order.last
    url = URI("https://sandbox.cashfree.com/pg/orders")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["accept"] = 'application/json'
    request["x-client-id"] = '3302190e0d94e003b104ea3484912033'
    request["x-client-secret"] = 'f81bc4e352bdfbf4c67bc93d4ab4c30faf1d1582'
    request["x-api-version"] = '2022-09-01'
    request["content-type"] = 'application/json'
    body = {
            customer_details: {
              customer_email: @order.email, customer_phone: "9876454321",
              customer_id: "customer#{@order_id}"
            },
            order_id: @order.id.to_s, order_amount: 21, order_currency: 'INR',
            order_meta: {
              return_url: 'http://localhost:8080' + "?order_id={order_id}",
              notify_url: 'http://localhost:8080'
            }
          } 
    request.body = body.to_json
    response = http.request(request)

    if response.present? && response.body.present?
      response = JSON.parse(response.body)
      @secret = response["payment_session_id"]
      render :cashfree_form

    else
      redirect_to product_out_of_stock_error_path(:error => 'Payment Failed') and return
    end

    
  end
end