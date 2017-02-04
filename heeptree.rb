class HeapTree
	def initialize
		@node = []
		@n = 0
	end

	private

	def left_key(key)
		2*key+1
	end

	def right_key(key)
		2*key+2
	end

	def from_root_swap(key)
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

	def from_leaf_swap(key)
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
		num = @node[0]
		@node[0] = @node.pop
		@n -= 1
		from_root_swap(0)
		return num
	end

	def insert!(num)
		@node << num
		@n += 1
		from_leaf_swap(@n-1)
	end

	# 先行順探索
	def precedingOrderSearch(key, &func)
		if @node[key]
			func.call(key, @node[key])
			precedingOrderSearch(@node[2*key+1], &func)
			precedingOrderSearch(@node[2*key+2], &func)
		end
	end
	# 後行順探索
	def afterLineOrderSearch(key, &func)
		if @node[key]
			afterLineOrderSearch(@node[2*key+1], &func)
			afterLineOrderSearch(@node[2*key+2], &func)
			func.call(key, @node[key])
		end
	end
	#中央順探索
	def centerOrderSearch(key, &func)
		if @node[key]
			centerOrderSearch(@node[2*key+1], &func)
			func.call(key, @node[key])
			centerOrderSearch(@node[2*key+2], &func)
		end
	end

	public

	def insert(num)
		insert!(num)
	end

	def preceding_crawl(&func) #　hoge.precedingCrawl do |key, value| のように使う
		precedingOrderSearch(0, &func)
	end

 # 後行巡回
 def after_line_crawl(&func)
 	afterLineOrderSearch(0, &func)
 end

# 中央巡回
def center_crawl(&func)
	centerOrderSearch(0, &func)
end

def extract
	extract!
end

def priority_create
	i = 0
	loop{
		key = (@n-1)/2-i
		break if key < 0
		from_root_swap(key)
		i += 1
	}
end

def list
	return @node
end
end
