require "rails_helper"
require "decidim/proposals/test/factories"

RSpec.describe 'EquityCompositeIndexAutoAssigner' do
  subject do
    build(:proposal)
  end

  describe "when the model is saved" do
    describe 'and the logitude or latitude has not changed' do
      it 'does not assign the equity_composite_percentile attribute' do
        subject.save!
        expect(subject.equity_composite_index_percentile).to be_nil
      end
    end

    describe 'when the logitude or latitude is now present' do
      before(:each) do
        subject.latitude = 47.6154049
        subject.longitude = -122.3202612
      end

      describe 'and the EquityComposite record including that point is found' do
        before(:each) do
          allow(EquityComposite).to receive_message_chain(:contains_point, :first) do
            build(:equity_composite, composite_index_percentage: 0.459)
          end
        end

        it 'assigns the equity_composite_percentile attribute to the record' do
          subject.save!
          expect(subject.equity_composite_index_percentile).to be(0.459)
        end
      end

      describe 'and the EquityComposite including that point is not found' do
        before(:each) do
          allow(EquityComposite).to receive_message_chain(:contains_point, :first) do
            nil
          end
        end

        it 'assigns nil to the equity_composite_percentile attribute in the record' do
          subject.save!
          expect(subject.equity_composite_index_percentile).to be_nil
        end
      end
    end

    describe 'when the logitude or latitude is nil' do
      subject do
        build(:proposal)
      end

      before(:each) do
        allow(EquityComposite).to receive_message_chain(:contains_point, :first) do
          nil
        end
      end

      it 'assigns nil to the equity_composite_percentile attribute in the record' do
        subject.save!
        expect(subject.equity_composite_index_percentile).to be_nil
      end
    end
  end
end