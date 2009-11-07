require 'net/http'
require 'uri'
require 'nokogiri'

class Pygrack
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)

    content = ''
    response.each{|str| content += str}

    doc = Nokogiri::HTML(content)
    nodes = doc.css("pre.code")
    nodes.each do |node|
      lang = node.attribute('class').value.gsub(/code (.*)/, '\1')
      code = node.content
      pygresp = Net::HTTP.post_form(URI.parse('http://pygments.appspot.com/'), {'lang' => lang, 'code' => code})
      nokopyg = Nokogiri::HTML(pygresp.body)
      pyg = nokopyg.css("div.highlight").first
      node.replace(pyg)
    end

    response = doc.to_s
    headers["Content-Length"] = response.length.to_s
    [status, headers, [response]]
  end
  
end