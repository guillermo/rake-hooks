require 'test/unit'
require 'rake'
require 'rake/hooks'

class Store
  def self.<<(string)
    @@data ||= ""
    @@data << string
  end

  def self.to_s
    @@data || ""
  end

  def self.clean
    @@data = ""
  end
end


class TestRakeHooks < Test::Unit::TestCase
  if defined?(Rake::DSL)
    include Rake::DSL
  end

  def setup
    Rake::TaskManager.record_task_metadata = true
    Store.clean
  end

  def test_after
    task  :task do  Store << "wadus"; end
    after :task do  Store << "way"  ;  end

    execute(:task)

    assert_equal "wadusway", Store.to_s
  end

  def test_after_multiple
    task  :task_one do  Store << "wadus"; end
    task  :task_two do  Store << "badus"; end
    after :task_one, :task_two do  Store << "way"  ;  end

    execute(:task_one)
    assert_equal "wadusway", Store.to_s

    Store.clean

    execute(:task_two)
    assert_equal "badusway", Store.to_s
  end

  def test_before
    task   :supertask do Store << "wadus" ; end
    before :supertask do Store << "super" ; end

    execute(:supertask)
    assert_equal "superwadus", Store.to_s
  end

  def test_after_and_before
    task   :super_task do Store << "wadus" ; end
    before :super_task do Store << "love " ; end
    before :super_task do Store << "I "    ; end
    after  :super_task do Store << " way"  ; end
    after  :super_task do Store << "."     ; end

    execute(:super_task)
    assert_equal "I love wadus way.", Store.to_s
  end

  def test_save_comment_on_after_tasks
    desc 'this is my task'
    task :my_task do ; end

    after :my_task do; end
    assert_equal "this is my task", Rake::Task[:my_task].full_comment
  end


  def test_save_comment_on_before_tasks
    desc 'this is my task'
    task :my_task2 do ; end

    before :my_task2 do; end
    assert_equal "this is my task", Rake::Task[:my_task2].full_comment
  end

  def execute(task_name)
    Rake::Task[task_name].execute
  end
end
