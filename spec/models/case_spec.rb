require 'spec_helper'

describe Case do
  it {should belong_to :patient}
  it {should validate_presence_of :recipient}
  it {should validate_presence_of :patient}
  it {should have_many :attachments}
  it {should have_many :messages}
  it {should have_many :case_watchers}
  it {should have_many :watching_practices}
end

