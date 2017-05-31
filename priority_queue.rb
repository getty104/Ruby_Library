class PriorityQueue
  class Element
    include Comparable

    attr_accessor :data, :priority

    def initialize(data, priority)
      @data, @priority = data, priority
    end

    def <=>(other) #最大を出したい時は-を外す
        -@priority <=> -other.priority
    end
  end

  def initialize
    @elements = []
  end

  def push (element, priority)
    @elements << Element.new(element,priority)
  end

  def pop
    last_element_index = @elements.size - 1
    @elements.sort!
    @elements.delete_at(last_element_index)
  end
end