class PriorityQueue

	def initialize size
		@heap = 0
		@node = Array.new(size)
	end

	def initialize
		@heap = 0
		@node = []
	end

	private

	def maxHeapfy key
		left = 2 * key
		right = 2 * key + 1

		if left <= @heap && @node[left] < @node[key]
			largest = left
		else
			largest = key
		end

		largest = right	if right <= @heap && @node[right] < @node[largest]

		unless largest == key
			@node[key], @node[largest] = @node[largest], @node[key]
			maxHeapfy largest
		end
	end

	def extract!
		return Float::INFINITY if @heap < 1
		maxv = @node[1]
		@node[1] = @node[@heap]
		@heap -= 1
		maxHeapfy 1
		return maxv
	end

	def increaseKey i, key
		return nil if key > @node[i]
		@node[i] = key
		while i > 1 && @node[i / 2] > @node[i]
			@node[i], @node[i / 2] = @node[i / 2], @node[i]
			i = i / 2
		end
	end

	def insert! key
		@heap += 1
		@node[@heap] = Float::INFINITY
		increaseKey @heap, key
	end

	public

	def << key
		insert! key
	end

	def pop
		extract!
	end

	def empty?
		@node.empty?
	end
end
pq = PriorityQueue.new

100.times do |i|
	pq << i
end

100.times do
	puts pq.pop
end