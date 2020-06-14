# frozen_string_literal: true

class ApplicationSerializer < ActiveModel::Serializer
  def self.collection_serialize(resources)
    ActiveModelSerializers::SerializableResource.new(resources, each_serializer: self)
  end
end
