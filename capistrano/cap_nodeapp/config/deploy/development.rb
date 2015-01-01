role :app, %w{192.168.1.8};

server '192.168.1.8', user: 'vagrant', roles: %w{app}, ssh_options: { password: 'vagrant' }
