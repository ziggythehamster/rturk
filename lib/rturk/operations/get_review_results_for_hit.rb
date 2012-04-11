module RTurk
  class GetReviewResultsForHIT < Operation

    require_params :hit_id
    attr_accessor :hit_id, :policy_level, :assignment_id, :retrieve_actions, :retrieve_results

    def parse(xml)
      RTurk::GetReviewResultsForHITResponse.new(xml)
    end

    def to_params
      {
        "HITId" => self.hit_id,
        "PolicyLevel" => self.policy_level,
        "AssignmentId" => self.assignment_id,
        "RetrieveActions" => self.retrieve_actions,
        "RetrieveResults" => self.retrieve_results
      }
    end
  end

  def self.GetReviewResultsForHIT(*args, &blk)
    RTurk::GetReviewResultsForHIT.create(*args, &blk)
  end

end

# vim: ts=2 sw=2 sts=2 et
