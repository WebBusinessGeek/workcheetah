module Jobs
  class Rating

     MERIT_VALUE =
     {"None/Other" => 0, "Completed" => 10,
      "GED" => 10, "Certification of Completion" => 10,
      "Diploma" => 20, "Associate of the Arts" => 30,
      "Associate of Science" => 30, "Bachelor of Arts" => 40,
      "Bachelor of Science" => 40, "Master of Arts" => 45,
      "Master of Science" => 45, "PhD" => 50}

    def initialize(job)
      @job = job
      @score = 0
    end

    def get_score
      generate_score
      @score
    end

    private
      def generate_score
        @score += skill_points
        @score += MERIT_VALUE[@job.merit_requested] unless @job.merit_requested.nil? || @job.merit_requested.blank?
        @score += 15 if @job.account.safe_job_seal?
        @score += 2 if @job.description?
        @score += 3 if @job.questionaire
      end

      def skill_points
        skill_points = @job.skills.count * 10
        if skill_points > 50
          return 50
        else
          return skill_points
        end
      end
  end
end