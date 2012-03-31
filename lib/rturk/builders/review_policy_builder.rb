require 'cgi'

module RTurk
  class ReviewPolicy

    attr_accessor :policy_name, :parameters

    def initialize(policy_name, params = {})
      @policy_name = policy_name
      @parameters = params
    end

    # Converts the given hash into MapEntry tags.
    def hash_to_map_entry(hash)
      xml = ""
      hash.each_pair do |key, value|
        xml << "<MapEntry>\n"
        xml << "<Key>#{CGI.escapeHTML(key.to_s)}</Key>\n"

        if value.is_a?(Hash)
          xml << hash_to_map_entry(value)
        elsif value.is_a?(Array)
          value.each do |arr_val|
            xml << "<Value>#{CGI.escapeHTML(arr_val.to_s)}</Value>\n"
          end
        else
          xml << "<Value>#{CGI.escapeHTML(value.to_s)}</Value>\n"
        end

        xml << "</MapEntry>\n"
      end

      xml
    end

    def to_params
      raise RTurk::MissingParameters, "needs a policy name to build a review policy" unless @policy_name
      raise RTurk::MissingParameters, "needs parameters to build a review policy" unless @policy_name

      xml = "<PolicyName>#{CGI.escapeHTML(@policy_name)}</PolicyName>\n"

      @parameters.each_pair do |key, value|
        xml << "<Parameter>\n"
        xml << "<Key>#{CGI.escapeHTML(key.to_s)}</Key>\n"

        if value.is_a?(Hash)
          xml << hash_to_map_entry(value)
        elsif value.is_a?(Array)
          value.each do |arr_val|
            xml << "<Value>#{CGI.escapeHTML(arr_val.to_s)}</Value>\n"
          end
        else
          xml << "<Value>#{CGI.escapeHTML(value.to_s)}</Value>\n"
        end

        xml << "</Parameter>"
      end

      xml
    end
  end
end

# vim: ts=2 sw=2 sts=2 et