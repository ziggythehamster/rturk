module RTurk
  class ReviewPolicy

    attr_accessor :policy_name, :parameters

    def initialize(policy_name, params = {})
      @policy_name = policy_name
      @parameters = params
    end

    # Converts the given hash into MapEntry tags.
    def hash_to_map_entry(hash, parameter_index)
      params = {}

      map_index = 0
      hash.each_pair do |key, value|
        params["Parameter.#{parameter_index}.MapEntry.#{map_index}.Key"] = key.to_s

        if value.is_a?(Hash)
          raise NotImplementedError, "MTurk does not allow a MapEntry within a MapEntry."
        elsif value.is_a?(Array)
          value.each_index do |idx|
            params["Parameter.#{parameter_index}.MapEntry.#{map_index}.Value.#{idx}"] = value[idx].to_s
          end
        else
          params["Parameter.#{parameter_index}.MapEntry.#{map_index}.Value"] = value.to_s
        end

        map_index = map_index + 1
      end

      return params
    end

    def to_params
      raise RTurk::MissingParameters, "needs a policy name to build a review policy" unless @policy_name
      raise RTurk::MissingParameters, "needs parameters to build a review policy" unless @parameters

      params = { "PolicyName" => @policy_name }

      parameter_index = 0
      @parameters.each_pair do |key, value|
        params["Parameter.#{parameter_index}.Key"] = key.to_s

        if value.is_a?(Hash)
          params.merge!(hash_to_map_entry(value, parameter_index))
        elsif value.is_a?(Array)
          value.each_index do |idx|
            params["Parameter.#{parameter_index}.Value.#{idx}"] = value[idx].to_s
          end
        else
          params["Parameter.#{parameter_index}.Value"] = value.to_s
        end

        parameter_index = parameter_index + 1
      end

      return params
    end
  end
end

# vim: ts=2 sw=2 sts=2 et
