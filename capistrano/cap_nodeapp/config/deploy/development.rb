role :app, %w{192.168.1.7};

server '192.168.1.7', user: 'vagrant', roles: %w{app}, ssh_options: { password: 'vagrant' }
