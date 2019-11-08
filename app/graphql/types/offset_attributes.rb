module Types
  class OffsetAttributes < BaseInputObject
    description "Attributes for pagination"

    argument :limit, Integer, required: true
    argument :offset, Integer, required: true
  end
end