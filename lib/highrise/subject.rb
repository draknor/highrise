module Highrise
  class Subject < Base
    def notes
      Note.find_all_across_pages(from: "/#{self.class.collection_name}/#{id}/notes.xml")
    end

    def notes_each
      Note.find_each(:from => "/#{self.class.collection_name}/#{id}/notes.xml") { |record| yield record }
    end

    def notes_each_since(time)
      Note.find_each(from: "/#{self.class.collection_name}/#{id}/notes.xml",params: {since: time.utc.strftime("%Y%m%d%H%M%S")}) { |record| yield record }
    end

    def add_note(attrs={})
      attrs[:subject_id] = self.id
      attrs[:subject_type] = self.label
      Note.create attrs
    end
    
    def add_task(attrs={})
      attrs[:subject_id] = self.id
      attrs[:subject_type] = self.label
      Task.create attrs
    end

    def emails
      Email.find_all_across_pages(params: params, from: "/#{self.class.collection_name}/#{id}/emails.xml"))
    end

    def emails_each
      Email.find_each(:from => "/#{self.class.collection_name}/#{id}/emails.xml") { |record| yield record}
    end

    def emails_each_since(time)
      Email.find_each(from: "/#{self.class.collection_name}/#{id}/emails.xml", params: {since: time.utc.strftime("%Y%m%d%H%M%S")}) { |record| yield record }
    end

    def upcoming_tasks
      Task.find(:all, :from => "/#{self.class.collection_name}/#{id}/tasks.xml")
    end
    
    def label
      self.class.name.split('::').last
    end
  end
end