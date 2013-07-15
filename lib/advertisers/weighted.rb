module Advertisers
  class Weighted
    attr_reader :list, :uniq
    attr_writer :weighed_func

    def initialize(list, opts={}, &block)
      @list = list
      @uniq = opts[:uniq] || false
      @weighed_func = block if block_given?
    end

    def get(count=1, &block)
      func = block || weighed_func
      mlist = MappedList.new(list, func, uniq)
      result = mlist.random(count)
      count == 1 ? result.first : result
    end

    def weighed_func
      @weighed_func ||= begin
        Proc.new do |val|
          val
        end
      end
    end

    class CircleIterator
      attr_reader :func, :obj, :max

      def initialize(obj, func, max)
        @obj = obj.dup
        @func = func
        @max = max
      end

      def each
        until obj.empty?
          start = 0
          obj.each do |item, weight|
            val = func.call(weight)
            start += val
            if yield([item, start, max])
              obj.delete item
              @max -= val
            end
          end
        end
      end
    end

    class MappedList
      attr_reader :list, :func, :uniq

      def initialize(list, func, uniq=false)
        @func = func
        @uniq = uniq
        @list = list
        @current_state = 0
      end

      def each(&block)
        CircleIterator.new(@list, func, max).each do |item|
          if uniq
            true if yield item
          else
            nil while yield(item)
          end
        end
      end

      def random(count)
        raise "The array is shorter than the count of items you wish to get." if uniq && list.size < count
        nums = count.times.map{ rand(max) }.sort
        get_random_items(nums)
      end

      def get_random_items(nums)
        current_num = nums.shift
        items = []
        each do |item, counter, mx|
          break unless current_num
          if counter%(mx+1) > current_num%mx
            items << item
            current_num = nums.shift
            true
          end
        end
        items
      end

      def max
        @max ||= begin
          max = 0
          list.each{ |item| max += func.call(item[1]) }
          max
        end
      end
    end
  end
end