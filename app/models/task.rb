class Task < ApplicationRecord
  belongs_to :list

  validates_presence_of :name, :list_id

  after_save :verify_done

  def verify_done
    slist = self.list
    if !slist.nil?
      number_tasks = slist.tasks.count
      tasks = slist.tasks
      tasks_done = []
      tasks.each do |task|
        if task.done
          tasks_done.push(true)
        end
      end
      if tasks_done.count == number_tasks
        slist.update_columns(done: true)
      end
    end
  end
end