class UniqueIdentifierGenerator
  VALUE_OFFSET = 9
  CONVERT_BASE = 36

  class << self
    def generate_for_id(id:)
      (VALUE_OFFSET + id).to_s(CONVERT_BASE)
    end
  end
end
