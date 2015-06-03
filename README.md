# Hl7::Push::Server

Emulates a practice management or electronic health record system that outputs HL7 messages via MLLP once a client has connected
via a TCP connection.  Useful for testing healthcare software integration with services that require the consuming application to connect.

Currently very basic and rudimentary synchronous socket IO.

## Installation

Add this line to your application's Gemfile:

    gem 'hl7-push-server'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hl7-push-server

## Usage

    To run
    `hl7-push-server server

## Contributing

1. Fork it ( http://github.com/<my-github-username>/hl7-push-server/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
