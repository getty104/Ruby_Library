class PriorityQueue

	def initialize a = 1, b = 0
		@heap = 0
		@node = []
		@option = a - b
	end

	private

	def maxHeapfy key
		left = 2 * key
		right = 2 * key + 1

		if left <= @heap && @node[left] > @node[key]
			largest = left
		else
			largest = key
		end

		largest = right	if right <= @heap && @node[right] > @node[largest]

		unless largest == key
			@node[key], @node[largest] = @node[largest], @node[key]
			maxHeapfy largest
		end
	end

	def max_extract!
		return -Float::INFINITY if @heap < 1
		maxv = @node[1]
		@node[1] = @node[@heap]
		@heap -= 1
		maxHeapfy 1
		return maxv
	end

	def max_increaseKey i, key
		return if key < @node[i]
		@node[i] = key
		while i > 1 && @node[i / 2] < @node[i]
			@node[i], @node[i / 2] = @node[i / 2], @node[i]
			i = i / 2
		end
	end

	def max_insert! key
		@heap += 1
		@node[@heap] = -Float::INFINITY
		max_increaseKey @heap, key
	end


	def minHeapfy key
		left = 2 * key
		right = 2 * key + 1

		if left <= @heap && @node[left] < @node[key]
			minimum = left
		else
			minimum = key
		end

		minimum = right	if right <= @heap && @node[right] < @node[minimum]

		unless minimum == key
			@node[key], @node[minimum] = @node[minimum], @node[key]
			minHeapfy minimum
		end
	end

	def min_extract!
		return Float::INFINITY if @heap < 1
		minv = @node[1]
		@node[1] = @node[@heap]
		@heap -= 1
		minHeapfy 1
		return minv
	end

	def min_increaseKey i, key
		return nil if key > @node[i]
		@node[i] = key
		while i > 1 && @node[i / 2] > @node[i]
			@node[i], @node[i / 2] = @node[i / 2], @node[i]
			i = i / 2
		end
	end

	def min_insert! key
		@heap += 1
		@node[@heap] = Float::INFINITY
		min_increaseKey @heap, key
	end

	public

	def << key
		if @option <= 0
			min_insert! key
		else
			max_insert! key
		end
	end

	def pop
		if @option <= 0
			min_extract!
		else
			max_extract!
		end
	end

	def empty?
		@node.empty?
	end

end