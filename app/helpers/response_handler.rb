class ResponseHandler
  attr_reader :response, :parser

  def initialize(response, parser)
    @response = response
    @parser = parser
  end

  def parse
    parser.new(response.body).run
  end
end
