$LOAD_PATH.unshift File.dirname(__FILE__)

require 'bundler'
Bundler.setup

require 'rest-client'
require 'json'
require 'active_support'

require 'riddler/client'
require 'riddler/exceptions'

require 'riddler/models/exceptions'
require 'riddler/models/session'
require 'riddler/models/list'
require 'riddler/models/video_list'
require 'riddler/models/video'
require 'riddler/models/playlist'
require 'riddler/models/regular_playlist'
require 'riddler/models/smart_playlist'
require 'riddler/models/user'
require 'riddler/models/playlist_list'