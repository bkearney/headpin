# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_headpin_session',
  :secret      => '86a1f10194ee44789e9a6af418b2a42e6aa1fe5949ffa93ab841a7b47d3f240b45dfee2a835121e5299a91fb33523e92270b5cd5b7d9de2858315311977f5ca8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
