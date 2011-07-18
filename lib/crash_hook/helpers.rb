class String
  unless method_defined?(:constantize)
    def constantize
      names = self.split('::')
      names.shift if names.empty? || names.first.empty?
  
      constant = Object
      names.each do |name|
        constant = constant.const_defined?(name) ? constant.const_get(name) : constant.const_missing(name)
      end
      constant
    end
  end
end
