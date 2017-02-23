
class DisjointSet 

	def initialize(size = nil)
		@rank = Array.new(size){0}
		@p = Array.new(size){0}
		if size 
			size.times do |i|
				@p[i] = i
			end
		end
	end

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
		@p[x] = findSet(@p[x]) unless x == @p[x] 
		return @p[x]
	end

	public

	def same(x, y)
		return findSet(x) == findSet(y)
	end

	def unite(x, y)
		link(findSet(x), findSet(y))
	end

end
