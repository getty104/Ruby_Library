class DisjointSet 
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

	def link(x, y)
		if @rank[x] > @rank[y]
			@p[y] = x
		else
			@p[x] = y
			@rank[y] += 1 if @rank[x] == @rank[y]
		end
	end

	def findSet(x)
		@p[x] = findSet(@p[x]) unless x == @p[x] 
		return @p[x]
	end

end


n,q = gets.split.map(&:to_i)

ds = DisjointSet.new(n)

q.times do |i|
	t, a, b = gets.split.map(&:to_i)
	
	if t == 0
		ds.unite(a, b)
	elsif t == 1
		if ds.same(a, b)
			puts 1
		else
			puts 0
		end
	end
end






