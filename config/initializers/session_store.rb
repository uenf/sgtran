# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sgf_session',
  :secret      => 'b2e0e072d107c2f039ac5d7536417e558054ac564bdba20709c009c859a2ca0141bbddb0f7179579321cbf1bef181cd220ff8b8694a9cb9cdc2667b8c5e5ad54'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
