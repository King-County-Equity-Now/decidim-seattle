require "rails_helper"
require "decidim/proposals/test/factories"

RSpec.describe 'EquityCompositeIndexAutoAssigner' do
  subject do
    create(:proposal)
  end

  describe "saving" do
    describe 'when the coordinates have not changed' do
      it 'does not populate the equity_composite_percentile attribute' do
        subject.save!
        expect(subject.equity_composite_index_percentile).to be_nil
      end
    end

    describe 'when the coordinates are now present' do
      before(:each) do
        subject.latitude = 47.6154049
        subject.longitude = -122.3202612
      end

      describe 'and an EquityComposite record including that coordinate was found' do
        before(:each) do
          allow(EquityComposite).to receive_message_chain(:contains_point, :first) do
            build(:equity_composite, composite_index_percentage: 0.459)
          end
        end

        it 'caches equity_composite_index_percentile on the record' do
          subject.save!
          expect(subject.equity_composite_index_percentile).to be(0.459)
        end
      end

      describe 'and an EquityComposite including that coordinate was not found' do
        before(:each) do
          allow(EquityComposite).to receive_message_chain(:contains_point, :first) do
            nil
          end
        end

        it 'assigns nil to the equity_composite_index_percentile' do
          subject.save!
          expect(subject.equity_composite_index_percentile).to be_nil
        end
      end
    end

    describe 'when the coordinates are no longer present' do
      subject do
        create(:proposal, latitude: 47.6154049, longitude: -122.3202612)
      end

      before(:each) do
        subject.latitude = nil
        subject.longitude = nil

        allow(EquityComposite).to receive_message_chain(:contains_point, :first) do
          nil
        end
      end

      it 'assigns nil to the equity_composite_index_percentile attribute' do
        subject.save!
        expect(subject.equity_composite_index_percentile).to be_nil
      end
    end
  end
end