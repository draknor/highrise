module Highrise
  class Task < Base
    # find(:all, :from => :upcoming)
    # find(:all, :from => :assigned)  
    # find(:all, :from => :completed)  

    def complete!
      load_attributes_from_response(post(:complete))
    end

    def self.all
      find(:all, from: :all)
    end

    def self.upcoming
      find(:all, from: :upcoming)
    end

    def self.assigned
      find(:all, from: :assign)
    end

    def self.completed
      find(:all, from: :completed)
    end

    def self.today
      find(:all, from: :today)
    end

  end
end