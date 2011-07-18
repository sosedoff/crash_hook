module CrashHook
  module Serializer
    def serializable?(value)
      value.is_a?(Fixnum) ||
      value.is_a?(Array) ||
      value.is_a?(String) ||
      value.is_a?(Hash) ||
      value.is_a?(Bignum)
    end

    def clean_non_serializable_data(data)
      data.select{|k,v| serializable?(v) }.inject({}) do |h, pair|
        h[pair.first] = pair.last.is_a?(Hash) ? clean_non_serializable_data(pair.last) : pair.last
        h
      end
    end
  end
end