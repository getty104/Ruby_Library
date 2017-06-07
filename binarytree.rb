# 二分探索木
class Tree
	# 節の定義
	class Node
		def initialize(key, data)
			@key = key
			@data = data
			@left = nil
			@right = nil
		end
		attr_accessor :key, :data, :left, :right
	end

	def initialize
		@root = nil
	end

	# 操作関数
	private

	# 探索
	def search(node, key)
		while node
			if key == node.key
				return node
			elsif key < node.key
				node = node.left
			else
				node = node.right
			end
		end
	end

	# 挿入
	def insert!(node, key, data)
		if node == nil
			return Node.new(key, data)
		elsif key == node.key
			node.data = data
		elsif key < node.key
			node.left = insert!(node.left, key, data)
		else
			node.right = insert!(node.right, key, data)
		end
		node
	end

	# 最小値を探す
	def search_min(node)
		node = node.left while node.left
		node
	end

	# 最大値を探す
	def search_max(node)
		node = node.right while node.right
		node
	end

	# 最小値を削除する
	def delete_min!(node)
		return node.right unless node.left
		node.left = delete_min!(node.left)
		node
	end

	# 削除
	def delete!(node, key)
		data = nil
		if node
			if key == node.key
				data = node.data
				if node.left == nil
					return node.right, data
				elsif node.right == nil
					return node.left, data
				else
					min_node = search_min(node.right)
					node.key = min_node.key
					node.data = min_node.data
					node.right = delete_min!(node.right)
				end
			elsif key < node.key
				node.left, data = delete!(node.left, key)
			else
				node.right, data = delete!(node.right, key)
			end
		end
		return node, data
	end

	# 先行順探索
	def precedingOrderSearch(node, &func)
		if node
			func.call(node.key, node.data)
			precedingOrderSearch(node.left, &func)
			precedingOrderSearch(node.right, &func)
		end
	end
	# 後行順探索
	def afterLineOrderSearch(node, &func)
		if node
			afterLineOrderSearch(node.left, &func)
			afterLineOrderSearch(node.right, &func)
			func.call(node.key, node.data)
		end
	end
	#中央順探索
	def centerOrderSearch(node, &func)
		if node
			centerOrderSearch(node.left, &func)
			func.call(node.key, node.data)
			centerOrderSearch(node.right, &func)
		end
	end


	public

	# 探索
	def find(key)
		node = search(@root, key)
		if node
			node.data
		end
	end

	# 挿入 (更新)
	def insert(key, value)
		@root = insert!(@root, key, value)
	end

	# 削除
	def delete_key(key)
		@root, data = delete!(@root, key)
		data
	end

	# 最小値を求める
	def min
		if @root
			node = search_min(@root)
			if node
				return node.key, node.data
			end
		end
	end

	# 最大値を求める
	def max
		if @root
			node = search_max(@root)
			if node
				return node.key, node.data
			end
		end
	end

	# 先行巡回
	def preceding_crawl(&func) #　hoge.precedingCrawl do |key, value| のように使う
		precedingOrderSearch(@root, &func)
	end

# 後行巡回
def after_line_crawl(&func)
	afterLineOrderSearch(@root, &func)
end

# 中央巡回
def center_crawl(&func)
	centerOrderSearch(@root, &func)
end


def inspect
	sprintf("#<Tree:%#x>", self.object_id)
end
end