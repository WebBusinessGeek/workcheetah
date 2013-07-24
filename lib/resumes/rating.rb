module Resumes
  class Rating
    attr_reader :score

    MERIT_VALUE =
     {"None/Other" => 10, "Completed" => 10,
      "GED" => 10, "Certification of Completion" => 10,
      "Diploma" => 20, "Associate of the Arts" => 30,
      "Associate of Science" => 30, "Bachelor of Arts" => 40,
      "Bachelor of Science" => 40, "Master of Arts" => 45,
      "Master of Science" => 45, "PhD" => 50}

    def initialize(resume)
      @resume = resume
      @score = 0
    end

    def get_score
      generate_score
      @score
    end
    private
      def generate_score
        @score += @resume.skills.count * 10
        @score += 10 if @resume.video.present?
        @score += @resume.references.where(confirmed: true).count
        merits = @resume.schools.pluck(:highest_merit)
        merits.each {|m| @score += MERIT_VALUE[m] unless m.nil?}
      end
  end
end