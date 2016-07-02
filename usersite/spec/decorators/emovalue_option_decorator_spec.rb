require 'rails_helper'

describe EmovalueOptionDecorator do
  let(:emovalue_option) { EmovalueOption.new.extend EmovalueOptionDecorator }
  subject { emovalue_option }
  it { should be_a EmovalueOption }
end
