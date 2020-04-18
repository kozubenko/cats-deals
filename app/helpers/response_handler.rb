class ResponseHandler
  attr_reader :response, :parser

  def initialize(response, parser: ::Parsers::JsonParser)
    @response = response
    @parser = parser
  end

  def parse
    parser.new(response.body).run
  end
end
