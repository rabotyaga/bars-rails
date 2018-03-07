# frozen_string_literal: true

class Log < ApplicationRecord
  default_scope { order('created_at DESC') }

  belongs_to :user
  belongs_to :article
  belongs_to :action

  serialize :data

  validates_presence_of :user, :article, :action, :data
end
