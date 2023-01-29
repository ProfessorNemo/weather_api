# frozen_string_literal: true

RSpec.describe "sidekiq-scheduler" do
  sidekiq_file = 'config/schedule.yml'
  schedule = YAML.load_file(sidekiq_file)[:schedule]

  describe "cron syntax" do
    schedule.each do |k, v|
      cron = v["cron"]
      it "#{k} has correct cron syntax" do
        expect { Fugit.do_parse(cron) }.not_to raise_error
      end
    end
  end

  describe "job classes" do
    schedule.each do |k, v|
      klass = v["class"]
      it "#{k} has #{klass} class in /jobs" do
        expect { klass.constantize }.not_to raise_error
      end
    end
  end

  describe "job names" do
    schedule.each do |k, v|
      klass = v["class"]
      it "#{k} has correct name" do
        expect(k).to eq(klass.underscore)
      end
    end
  end

  describe "job cron forecast_job" do
    cron = schedule['forecast_job']['cron']
    c = Fugit::Cron.parse(cron)

    it "#{cron} has correct value" do
      if c.methods.include?(:hours) && c.methods.include?(:rough_frequency)
        expect(c.send(:hours)).to eq([0, 3, 6, 9, 12, 15, 18, 21])

        expect(c.send(:rough_frequency)).to eq(10_800)
      end

      expect(Fugit.parse('every 3 hours in Europe/Moscow').original).to eq(cron)
    end
  end

  describe "job cron check_fill_bd_job" do
    cron = schedule['check_fill_bd_job']['cron']
    c = Fugit::Cron.parse(cron)

    it "#{cron} has correct value" do
      expect(c.send(:rough_frequency)).to eq(60) if c.methods.include?(:rough_frequency)

      expect(Fugit.parse('every 1 minute in Europe/Moscow').original).to eq(cron)
    end
  end
end
