require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

every(5.minute, 'Queueing interval job') { Notification.delay(run_at: 1.minute.from_now).birthday('dailyin@luch.podolsk.ru') }
