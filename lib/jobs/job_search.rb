module Jobs
  class JobSearch
    def initialize(params, session)
      @params = params
      @session = session
    end

    def call
      if @params[:categories]
        category = @params[:categories]
      elsif @params[:user]
        category = User.find(@params[:user][:id]).resume.recommended
      end
      if category
        return Job.job_search(category, @params[:location])
      else
        return Job.near(@params[:location], 50).order("created_at DESC")
      end
    end
  end
end