# frozen_string_literal: true

class MessageThread < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :messages
end
