def before(task_name, &new_task)    
  old_task = Rake.application.instance_variable_get('@tasks').delete(task_name.to_s)
  task task_name do
    new_task.call
    old_task.invoke
  end
end

def after(task_name, &new_task)  
  old_task = Rake.application.instance_variable_get('@tasks').delete(task_name.to_s)
  
  task task_name do
    old_task.invoke
    new_task.call
  end
end
