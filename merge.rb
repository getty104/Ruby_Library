module Merge
	def merge!(a,left,mid,right)
		n1 = mid - left
		n2 = right - mid
		l = []
		r = []
		n1.times do |i|
			l << a[left + i]
		end
		l << Float::INFINITY
		n2.times do |i|
			r << a[mid + i]
		end
		r << Float::INFINITY
		i = 0
		j = 0

		left.upto(right - 1) do |k|
			if l[i] <= r[j]
				a[k] = l[i]
				i += 1
			else
				a[k] = r[j]
				j += 1
			end
		end
	end

	def merge_sort!(a, left, right)
		if left + 1 < right
			mid = (left + right)/2
			merge_sort!(a, left, mid)
			merge_sort!(a, mid, right)
			merge!(a, left, mid, right)
		end
	end

	module_function :merge!, :merge_sort!
end