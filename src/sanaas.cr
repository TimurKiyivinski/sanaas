require "./sanaas/*"
require "kemal"
require "json"

module Sanaas
    def self.san(input : String, separator : String)
        san = String.new
        input.each_char do |char|
            if char != 'e' && char != 'E'
                san += "#{char}#{separator}"
            end
        end
        san
    end

    get "/" do |env|
        env.response.content_type = "application/json"
        { "err": true, "messaage": "Please use the /san/:message endpoint to san a message" }
    end

    get "/san/:message" do |env|
        env.response.content_type = "application/json"
        input = env.params.url["message"].as(String)
        { "err": false, "san": san(input, "") }.to_json
    end

    get "/san/:message/:separator" do |env|
        env.response.content_type = "application/json"
        input = env.params.url["message"].as(String)
        separator = env.params.url["separator"].as(String)
        { "err": false, "san": san(input, separator) }.to_json
    end

    Kemal.run
end
