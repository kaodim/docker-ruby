module Util
  def self.present?(val)
    return false if val.nil?
    case val
    when String
      !val.empty?
    when Array
      val.length > 0
    when Hash
      val.keys.length > 0
    else
      true
    end
  end

  def self.blank?(val)
    !present?(val)
  end
end
