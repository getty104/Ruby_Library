class UnionFindTree

	def initialize(size = 1000)
		@par = Array.new(size)
		@size = Array.new(size){1}
		size.times do |i|
			@par[i] = i
		end
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