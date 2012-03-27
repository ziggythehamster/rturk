require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::GetReviewResultsForHIT do

  before(:all) do
    faker('get_review_results_for_hit', :operation => 'GetReviewResultsForHIT')
  end

  it "should fetch the review results of a HIT" do
    response = RTurk.GetReviewResultsForHIT(:hit_id => "1234abcd")
    response.assignment_review_policy.should eql("ScoreMyKnownAnswers/2011-09-01")
    response.hit_review_policy.should eql("SimplePlurality/2011-09-01")
    # AssignmentReviewReport
    # HITReviewReport
  end
end
