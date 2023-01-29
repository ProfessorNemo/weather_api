# frozen_string_literal: true

RSpec.describe ForecastJob do
  include ActiveJob::TestHelper

  subject(:job) { described_class.new.perform_now }

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  describe '#perform_now' do
    before { ActiveJob::Base.queue_adapter = :test }

    specify '#perform' do
      expect(described_class).to respond_to(:perform_now)
    end

    it 'specify that job was enqueued' do
      expect do
        described_class.perform_now
      end.to have_enqueued_job.at_least(1)
    end

    it 'queues the job' do
      expect { job }
        .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end
  end

  it 'queues the job' do
    expect { job }.to have_enqueued_job(described_class).on_queue('default')
  end

  it 'Describes the queue that a job should be processed in' do
    expect(described_class).to be_processed_in 'default'
  end

  it 'describes if a job should retry when there is a failure in its execution' do
    expect(described_class).to be_retryable 1
  end
end
