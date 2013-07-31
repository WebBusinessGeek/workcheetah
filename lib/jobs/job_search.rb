module Jobs
  class JobSearch
    def initialize(relation = Job.scoped, query = {})
      @relation = relation
      @query = query
    end

    def call
      puts @query[:categories]
      @relation = @relation.cat_search(@query[:categories]) if @query[:categories]
      # @relation = text_search(@query[:query]) if @query[:query]
      @relation = @relation.near(@query[:location],50)
      @relation
    end
  end
end