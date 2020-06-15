class ApplicationMailbox < ActionMailbox::Base
  routing :all => :orders
end
