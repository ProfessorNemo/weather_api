# frozen_string_literal: true

# хелпер для работы с форматами времени
module TimeHelper
  def time_epoch(time)
    Time.new(*time).strftime('%s').to_i
  end

  def parse_epoch(time)
    date = Time.zone.at(time)
    Date.parse(date.to_s).strftime('%F | %T')
  end
end

# подключение метода к тестам
RSpec.configure do |c|
  c.include TimeHelper
end
