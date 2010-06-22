require 'test/unit'
require 'rubygems'
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
  
  def setup
    Store.clean
  end
  
  def test_after
    task  :task do  Store << "wadus"; end
    after :task do  Store << "way"  ;  end
    
    execute(:task)

    assert_equal "wadusway", Store.to_s
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
  
  def execute(task_name)
    Rake::Task[task_name].execute
  end
end