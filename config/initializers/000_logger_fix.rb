# Fix for uninitialized constant ActiveSupport::LoggerThreadSafeLevel::Logger
# This initializer needs to load before ActiveSupport
require 'logger'

# Define Logger in the global namespace if it's not already defined
unless defined?(::Logger)
  ::Logger = ::Logger
end

# Monkey patch to fix the Logger constant issue in ActiveSupport
module ActiveSupport
  module LoggerThreadSafeLevel
    # Define Logger if it's not defined
    unless defined?(Logger)
      Logger = ::Logger
    end
  end
end
