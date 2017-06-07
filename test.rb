class UnionFindTree

	class ParArray < Hash
		def [] key
			self[key] = key if super(key).nil?
			super(key)
		end
	end

	class SizeArray < Hash
		def [] key
			self[key] = 1 if super(key).nil?
			super(key)
		end
	end

	def initialize()
		@par = ParArray.new
		@size = SizeArray.new
	end

	private

	def find(x)
		return x if x == @par[x]
		return @par[x] = find(@par[x])
	end

	public

	def unite(x, y)
		x = find(x)
		y = find(y)

		return nil if x == y
		x, y = y, x if @size[x] < @size[y]

		@par[y] = x
		@size[x] += @size[y]
	end

	def same?(x, y)
		return find(x) == find(y)
	end

	def size(x)
		return @size[find(x)]
	end

end
u = UnionFindTree.new
100.times do |i|
	u.unite(i, i+1)
end

100.times do |i|
p u.same?(i,i+1)
end

