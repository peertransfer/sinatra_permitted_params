require 'sinatra_permitted_params/version'

module Sinatra
  module PermittedParams
    class UnpermittedParamsError < StandardError; end

    WILDCARD_PARAMS = ['splat', 'captures']

    def permitted_params(permitted_keys, ignore: [])
      ignored_keys = stringify(ignore)
      permitted_keys = stringify(permitted_keys)

      filtered_params = reject_ignored_params(ignored_keys)

      check_params(filtered_params, permitted_keys)

      filtered_params
    end

    private

    def reject_ignored_params(ignored_keys)
      keys_to_ignore = ignored_keys + WILDCARD_PARAMS

      params.reject { |key, _| keys_to_ignore.include?(key) }
    end

    def check_params(filtered_params, permitted_keys)
      forbidden_keys = filtered_params.keys - permitted_keys
      return if forbidden_keys.empty?

      raise UnpermittedParamsError.new("Unpermitted params found: #{forbidden_keys.join(', ')}")
    end

    def stringify(values)
      values.map(&:to_s)
    end
  end
end
