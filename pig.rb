class Pig
  def call(env)
    html = <<-HTML
      <html>
        <head>
          <link rel="stylesheet" href="/public/default.css" type="text/css">
        </head>
        <body>
          <p>omfg</p>
          <div class="content">
            <pre class="code ruby">
              puts 'omfg'
              # this is a comment
              def poop
               a = 1
               puts a
              end
            </pre>
            <pre>this is a stupid pre tag</pre>
            <pre class="code ruby">
              def dudoop
                'dick pin!'
              end
            </pre>
            <pre class="code java">
              void side(PVector start, PVector end, PVector sspline, PVector espline, float tall, float lean) {
                float t = 0;
                beginShape(QUAD_STRIP);
                for (int i = 0; i = steps; i++) {
                  float x = curvePoint(sspline.x, start.x, end.x, espline.x, t);
                  float y = curvePoint(sspline.y, start.y, end.y, espline.y, t);
                  float z = curvePoint(sspline.z + lean, start.z, end.z, espline.z + lean, t);
                  vertex(x, y, z);

                  x = curvePoint(sspline.x, start.x, end.x, espline.x, t);
                  y = curvePoint(sspline.y - tall, start.y, end.y, espline.y - tall, t);
                  z = curvePoint(sspline.z + lean, start.z, end.z, espline.z + lean, t);
                  vertex(x, y, z);
                  t += dt;
                }
                endShape();
              }
            </pre>
          <div>
        </body>
      </html>
    HTML
    [200, {"Content-Type" => "text/html"}, html]
  end
end

if $0 == __FILE__
  require 'rack'
  require 'pygrack'

  app = Rack::Builder.new do
    use Rack::ShowExceptions
    map "/public" do
      run Rack::Directory.new("./public")
    end

    map "/" do
      use Pygrack
      use Rack::Lint
      run Pig.new
    end
  end

  Rack::Handler::WEBrick.run(app, :Port => 9292)
end