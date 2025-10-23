require "json"
require "rest-client"

module Poster
  class Base
    @poster_url = "https://joinposter.com/api"
    @token = ENV["POSTER_TOKEN"]

    class << self
      def transactions(params={})
        get("dash.getTransactions", params)
      end

      def delete_transaction(params={})
        post("transactions.removeTransaction", params)
      end

      def products(params={})
        get("menu.getProducts", params)
      end

      def update_product(params={})
        post("menu.updateProduct", params)
      end

      def online_order(params={})
        post("incomingOrders.createIncomingOrder", params)
      end

      def create_check(params={})
        post("incomingOrders.createIncomingOrder", params)
      end

      def update_customer(params={})
        post("clients.updateClient", params)
      end

      def customers(params={})
        get("clients.getClients", params)
      end

      def spots(params={})
        get("spots.getSpots", params)
      end

      def categories(params={})
        get("menu.getCategories", params)
      end

      def get(action, params={})
        json = JSON.parse(
          RestClient.get(
            "#{@poster_url}/#{action}",
            params: params.merge(token: @token)
          ).body
        )
        if json["error"]
          raise StandardError.new(json["error"])
        end
        json["response"]
      rescue => e
        puts e.inspect
      end

      def post(action, params={})
        json = JSON.parse(
          RestClient.post(
            "#{@poster_url}/#{action}?token=#{@token}",
            params.to_json,
            {
              "Content-Type" => "application/json"
            }
          ).body
        )
        if json["error"]
          raise StandardError.new(json["error"])
        end
        json["response"]
      rescue => e
        puts e.inspect
      end
    end
  end
end