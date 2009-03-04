# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_kb_session',
  :secret      => 'c674ca9d8b26c884cd866fcd3482cb1a0489dd80a1408ac65e822921e32e6b6f8ee656f171bb2a88a545bfa8d6d87a529b0097a238b9c2f66051d4740438edb2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
