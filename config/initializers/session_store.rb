# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_teste_session',
  :secret      => 'caad5546f858f41ccfd056b35156312f969bf10e00c38b8913ef4d55b7236acc4b35101490199fca6d64bce37ff83fa296c1992e4159ee86b5e18158363cf34a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
