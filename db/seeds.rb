fmueller = Admin.create! email: 'fmueller83@googlemail.com', password: 'install123', password_confirmation: 'install123'
primus = Domain.create! name: 'primus-fatum.de', admin: fmueller
loeffelkoenig = Domain.create! name: 'loeffelkoenig.de', admin: fmueller
handelsliga = Domain.create! name: 'handelsliga.de', admin: fmueller
info = User.create! username: 'info', password: 'install123', domain: primus
fate = User.create! username: 'fate', password: 'install123', domain: primus
torus = User.create! username: 'torus', password: 'install123', domain: primus
wurst = User.create! username: 'wurst', password: 'install123', domain: primus
Alias.create! user_source: 'fate2', domain_source: primus, user_destination: fate, domain_destination: primus
Alias.create! user_source: 'torus2', domain_source: primus, user_destination: torus, domain_destination: primus
Forwarding.create! user: info, domain: primus, destination: 'fate@primus-fatum.de'
Forwarding.create! user: info, domain: primus, destination: 'torus@primus-fatum.de'
Forwarding.create! user: info, domain: primus, destination: 'wurst@primus-fatum.de'