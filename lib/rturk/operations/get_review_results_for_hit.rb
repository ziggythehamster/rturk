module RTurk
  class GetReviewResultsForHIT < Operation

    require_params :hit_id
    attr_accessor :hit_id, :policy_level, :assignment_id, :retrieve_actions, :retrieve_results

    def parse(xml)
      RTurk::GetReviewResultsForHITResponse.new(xml)
    end

  end

  def self.GetReviewResultsForHIT(*args, &blk)
    RTurk::GetReviewResultsForHIT.create(*args, &blk)
  end

end
