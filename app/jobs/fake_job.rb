class FakeJob < ApplicationJob
  queue_as :default

  def perform
    puts "FakeJob Started"
    sleep 3
    puts "FakeJob done"
  end
end
