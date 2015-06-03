require 'socket'
require 'hl7-push-server/configuration'
require 'hl7-push-server/llp_message'
module HL7PushServer
  class Host

    attr_reader :config

    def initialize(config = HL7PushServer::Configuration.new)
      @config = config
      populate_sample_messages
      yield @config if block_given?

      @descriptors = []
      @serverSocket = TCPServer.new("", @config.port)
      @serverSocket.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, 1)
      puts "Listening for HL7 messages on port #{@config.port}."
      @descriptors.push(@serverSocket)
    end

    def run
      frame_count = 0
      while true
        res = select(@descriptors, nil, nil, 0)
        if res != nil then
          # Iterate through the tagged read descriptors
          res[0].each do |sock|
            # Received a connect request to the server (listening) socket
            if sock == @serverSocket then
              accept_new_connection
            else
              # Received end of file from a client socket
              if sock.eof? then
                # Disconnect and clean up socket
                puts "Client #{sock.peeraddr[2]}:#{sock.peeraddr[1]} disconnected"
                sock.close
                @descriptors.delete(sock)
              else
                # Output the message the client sent (arbitrary maximum bytes to receive)
                puts "Client #{sock.peeraddr[2]}:#{sock.peeraddr[1]}: #{sock.gets("\r")}"
              end
            end
          end
        end
        if frame_count == 100000
          each_client do |client|
            client.write("#{@messages[Random.rand(0..3)]}\r")
          end
          frame_count = 0
        end
        frame_count += 1
      end
    end

    private

    def each_client
      @descriptors.each do |socket|
        next if socket == @serverSocket
        yield socket
      end
    end

    def populate_sample_messages
      @messages = []
      Dir.glob('test/*.txt') do |raw_hl7_filepath|
        raw_msg = File.read(raw_hl7_filepath)
        puts raw_hl7_filepath
        raw_msg.strip!
        llp = HL7PushServer::LLPMessage.from_hl7 raw_msg
        @messages.push llp
      end
    end

    def accept_new_connection
      newsock = @serverSocket.accept
      @descriptors.push( newsock )
      puts "New client connected from #{newsock.peeraddr[2]}:#{newsock.peeraddr[1]}"
    end
  end
end