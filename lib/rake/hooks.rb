module Rake::Hooks
  def before(*task_names, &new_task)
    task_names.each do |task_name|
      old_task = Rake.application.instance_variable_get('@tasks').delete(task_name.to_s)
      desc old_task.full_comment
      task task_name => old_task.prerequisites do
        new_task.call
        old_task.invoke
      end
    end
  end

  def after(*task_names, &new_task)
    options = task_names.last.is_a?(Hash) ? task_names.pop : {}
    ignore_exceptions = options.delete(:ignore_exceptions) || false

    task_names.each do |task_name|
      old_task = Rake.application.instance_variable_get('@tasks').delete(task_name.to_s)
      desc old_task.full_comment
      task task_name => old_task.prerequisites do
        begin
          old_task.invoke
        rescue
          raise unless ignore_exceptions
        end

        new_task.call
      end
    end
  end
end

Rake::DSL.send(:include, Rake::Hooks) if defined?(Rake::DSL)
include Rake::Hooks unless self.class.included_modules.include?(Rake::Hooks)
