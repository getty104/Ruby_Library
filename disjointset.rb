class DisjointSet 
	private

	def link(x, y)
		if @rank[x] > @rank[y]
			@p[y] = x
		else
			@p[x] = y
			@rank[y] += 1 if @rank[x] == @rank[y]
		end
	end

	def findSet(x)
		@p[x] = findSet(@p[x])
		return @p[x]
	end

	public

	def initialize()
		@rank = []
		@p = []
	end

	def initialize(size)
		@rank = Array.new(size){0}
		@p = Array.new(size){0}

		size.times do |i|
			@p[i] = i
		end
	end

	def same(x, y)
		return findSet(x) == findSet(y)
	end

	def unite(x, y)
		link(findSet(x), findSet(y))
	end

end

