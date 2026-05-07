require 'yaml'

DATE = '2026.06.13 (Sat.) 14:00-20:00'
TWIPLA_URL = 'https://twipla.jp/events/669873'

INPUT = <<~TEXT
  名前\tジャンル\t所要時間\t開始時間\t終了時刻
  Takayuki Tominaga\tたのしい\t1:00:00\t14:00\t15:00
  うなすけ\tProgressive House\t1:00:00\t15:00\t16:00
  Rooq\t速いハウス\t1:00:00\t16:00\t17:00
  furaji\t5月で現在の会社が無くなりまstep\t1:00:00\t17:00\t18:00
  sylph01/G4きゅーぶ\tRubyIlluminationsの残り物(170+)\t1:00:00\t18:00\t19:00
  HolyGrail\tRubyIlluminations 後夜祭\t1:00:00\t19:00\t20:00
TEXT

lines = INPUT.lines.map(&:chomp).reject(&:empty?)
_header, *rows = lines

timetable = rows.map do |row|
  name, genre, _duration, start_time, _end_time = row.split("\t")
  {
    'time' => start_time,
    'screen_name' => name,
    'genre' => genre.to_s,
  }
end

data = {
  'date' => DATE,
  'twipla_url' => TWIPLA_URL,
  'timetable' => timetable,
}

output_path = File.expand_path('../data/event.yml', __dir__)
File.write(output_path, YAML.dump(data))
