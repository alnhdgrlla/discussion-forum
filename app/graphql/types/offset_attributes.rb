module Types
  class OffsetAttributes < BaseInputObject
    description "Attributes for pagination"

    argument :limit, Integer, required: false,
    argument :offset, Integer, required: false
  end
end