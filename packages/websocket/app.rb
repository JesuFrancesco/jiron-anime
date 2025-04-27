require 'websocket-eventmachine-server'
require 'eventmachine'
require 'json'

class WebSocketServer
    @connections = []

    def self.start(port = 8080)
        EM.run do
            WebSocket::EventMachine::Server.start(host: '0.0.0.0', port: port) do |ws|
                @connections << ws

                ws.onopen do
                    puts "Conexión WebSocket iniciada #{ws}"
                    x = {"sender" => "Servidor", "message" => "¡Bienvenido al foro!"}
                    ws.send x.to_json
                end

                ws.onmessage do |msg, _type|
                    puts "Mensaje recibido: #{msg}"
                    @connections.each do |conn|
                        x = {"sender" => "Anónimo", "message" => msg}
                        conn.send x.to_json unless conn == ws
                    end
                end

                ws.onclose do
                    puts 'Conexión WebSocket cerrada'
                    @connections.delete(ws)
                end

                ws.onerror do |error|
                    puts "WebSocket error: #{error}"
                end
            end

            puts "WebSocket server running on port #{port}"
        end
    end
end

WebSocketServer.start
