# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Nama::Application.initialize!

# Custom Date/Time Format
Date::DATE_FORMATS.merge!(:default => "%d.%m.%Y")
Time::DATE_FORMATS.merge!(:default => "%H:%M")
