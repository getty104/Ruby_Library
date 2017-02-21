class PriorityQueue
	def initialize
		@node = []
		@n = 0
	end

	private

	def left_key key
		2*key+1
	end

	def right_key key
		2*key+2
	end

	def from_root_swap key
		right = right_key(key)
		left = left_key(key)
		if  key < 0 
			return nil
		end
		if !@node[left] && !@node[right]
			return nil
		elsif @node[left] && !@node[right]
			if @node[left] > @node[key]
				@node[key], @node[left] =  @node[left], @node[key]
				from_root_swap(left)
			end
		elsif @node[right] && !@node[left]
			if @node[right] > @node[key]
				@node[key], @node[right] =  @node[right], @node[key]
				from_root_swap(right)
			end
		elsif @node[key] <= @node[left] && @node[left] >= @node[right]
			@node[key], @node[left] =  @node[left], @node[key]
			from_root_swap(left)
		elsif @node[key] <= @node[right] && @node[right] >= @node[left]
			@node[key], @node[right] =  @node[right], @node[key]
			from_root_swap(right)
		end
	end

	def from_leaf_swap key
		if key == 0
			return nil
		end
		parent_key = (key-1)/2
		if @node[parent_key] < @node[key]
			@node[key], @node[parent_key] = @node[parent_key], @node[key]
			from_leaf_swap(parent_key)
		end
	end

	def extract!
		node = @node[0]
		if @node.size == 0
			railse "Queue is Empty"
		elsif @node.size == 1
			@n -= 1
			return @node.pop
		else
			@n -= 1
			node = @node[0]
			@node[0] = @node.pop
			from_root_swap(0)
			return node
		end
	end

	def insert! num
		@node << num
		@n += 1
		from_leaf_swap(@n-1)
	end

	

	public

	def << num
		insert!(num)
	end

	def pop
		extract!
	end

	def empty?
		@node.empty?
	end

end
