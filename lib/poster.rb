require "faraday"
require "json"

module Poster
  class Error < StandardError
  end

  class Base
    BASE_URL = "https://joinposter.com/api"

    class << self
      def transactions(params = {})
        request(:get, "dash.getTransactions", params)
      end

      def delete_transaction(params = {})
        request(:post, "transactions.removeTransaction", params)
      end

      def products(params = {})
        request(:get, "menu.getProducts", params)
      end

      def update_product(params = {})
        request(:post, "menu.updateProduct", params)
      end

      def online_order(params = {})
        request(:post, "incomingOrders.createIncomingOrder", params)
      end

      def create_check(params = {})
        request(:post, "incomingOrders.createIncomingOrder", params)
      end

      def update_customer(params = {})
        request(:post, "clients.updateClient", params)
      end

      def customers(params = {})
        request(:get, "clients.getClients", params)
      end

      def spots(params = {})
        request(:get, "spots.getSpots", params)
      end

      def categories(params = {})
        request(:get, "menu.getCategories", params)
      end

      private

      def connection
        @connection ||= Faraday.new(url: BASE_URL) do |f|
          f.request(:url_encoded)
          f.adapter(Faraday.default_adapter)
          f.options.timeout = 10
          f.options.open_timeout = 5
        end
      end

      def request(method, action, params = {})
        query_params = {token: ENV["POSTER_TOKEN"]}

        response = if method == :get
          connection.get(action, query_params.merge(params))
        else
          connection.post("#{action}?#{URI.encode_www_form(query_params)}") do |req|
            req.headers["Content-Type"] = "application/json"
            req.body = params.to_json
          end
        end

        handle_response(response)
      rescue Faraday::Error => e
        raise Error, "Network error: #{e.message}"
      end

      def handle_response(response)
        begin
          body = JSON.parse(response.body)
        rescue JSON::ParserError
          raise Error, "Invalid JSON response: #{response.status}"
        end

        if body["error"]
          raise Error, "Poster API Error #{body["error"]}: #{body["message"]}"
        end

        body["response"]
      end
    end
  end
end
