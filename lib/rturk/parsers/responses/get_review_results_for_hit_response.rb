module RTurk
  class GetReviewResultsForHITResponse < Response
    attr_reader :hit_id, :assignment_review_policy, :hit_review_policy,
                :assignment_review_report, :hit_review_report

    def initialize(response)
      @raw_xml = response.body
      @xml = Nokogiri::XML(@raw_xml)
      raise_errors
      map_content(@xml.xpath('//GetReviewResultsForHITResult'),
        :hit_id => 'HITId',
	:assignment_review_policy => "AssignmentReviewPolicy",
	:hit_review_policy => "HITReviewPolicy"
      )
      @assignment_review_report = @xml.xpath("//GetReviewResultsForHITResult/AssignmentReviewReport/*").collect do |report|
        if report.name == "ReviewResult"
          {
            :type => "result",
            :action_id => report.at("ActionId").nil? ? nil : report.at("ActionId").content,
            :subject_id => report.at("SubjectId").nil? ? nil : report.at("SubjectId").content,
            :object_type => report.at("ObjectType").nil? ? nil : report.at("ObjectType").content,
            :question_id => report.at("QuestionId").nil? ? nil : report.at("QuestionId").content,
            :key => report.at("Key").nil? ? nil : report.at("Key").content,
            :value => report.at("Value").nil? ? nil : report.at("Value").content
          }
	elsif report.name == "ReviewAction"
          {
            :type => "action",
            :action_id => report.at("ActionId").nil? ? nil : report.at("ActionId").content,
            :action_name => report.at("ActionName").nil? ? nil : report.at("ActionName").content,
            :object_id => report.at("ObjectId").nil? ? nil : report.at("ObjectId").content,
            :object_type => report.at("ObjectType").nil? ? nil : report.at("ObjectType").content,
            :status => report.at("Status").nil? ? nil : report.at("Status").content,
            :complete_time => report.at("CompleteTime").nil? ? nil : report.at("CompleteTime").content,
            :result => report.at("Result").nil? ? nil : report.at("Result").content,
            :error_code => report.at("ErrorCode").nil? ? nil : report.at("ErrorCode").content
          }
	end
      end

      @hit_review_report = @xml.xpath("//GetReviewResultsForHITResult/HITReviewReport/*").collect do |report|
        if report.name == "ReviewResult"
          {
            :type => "result",
            :action_id => report.at("ActionId").nil? ? nil : report.at("ActionId").content,
            :subject_id => report.at("SubjectId").nil? ? nil : report.at("SubjectId").content,
            :object_type => report.at("ObjectType").nil? ? nil : report.at("ObjectType").content,
            :question_id => report.at("QuestionId").nil? ? nil : report.at("QuestionId").content,
            :key => report.at("Key").nil? ? nil : report.at("Key").content,
            :value => report.at("Value").nil? ? nil : report.at("Value").content
          }
	elsif report.name == "ReviewAction"
          {
            :type => "action",
            :action_id => report.at("ActionId").nil? ? nil : report.at("ActionId").content,
            :action_name => report.at("ActionName").nil? ? nil : report.at("ActionName").content,
            :object_id => report.at("ObjectId").nil? ? nil : report.at("ObjectId").content,
            :object_type => report.at("ObjectType").nil? ? nil : report.at("ObjectType").content,
            :status => report.at("Status").nil? ? nil : report.at("Status").content,
            :complete_time => report.at("CompleteTime").nil? ? nil : report.at("CompleteTime").content,
            :result => report.at("Result").nil? ? nil : report.at("Result").content,
            :error_code => report.at("ErrorCode").nil? ? nil : report.at("ErrorCode").content
          }
	end
      end
    end
  end
end

# vim: ts=2 sw=2 sts=2 et
