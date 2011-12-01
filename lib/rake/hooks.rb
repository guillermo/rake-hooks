module Rake::Hooks
  def before(*task_names, &new_task)
    task_names.each do |task_name|
      old_task = Rake.application.instance_variable_get('@tasks').delete(task_name.to_s)
      desc old_task.full_comment
      task task_name do
        new_task.call
        old_task.invoke
      end
    end
  end

  def after(*task_names, &new_task)
    task_names.each do |task_name|
      old_task = Rake.application.instance_variable_get('@tasks').delete(task_name.to_s)
      desc old_task.full_comment
      task task_name do
        old_task.invoke
        new_task.call
      end
    end
  end
end

Rake::DSL.send(:include, Rake::Hooks) if defined?(Rake::DSL)
include Rake::Hooks unless self.class.included_modules.include?(Rake::Hooks)
