require 'yaml'

NUMBER = 43
DATE = '2026.12.19 (Sat.) 14:00-20:00'
TWIPLA_URL = 'https://twipla.jp/events/752251'

INPUT = <<~TEXT
  名前	ジャンル	所要時間	開始時間	終了時刻
  うなすけ	EDM, Dub Step, Big Room	1:00:00	14:00	15:00
  furaji		1:00:00	15:00	16:00
  HolyGrail	忘年会	1:00:00	16:00	17:00
  DS		1:00:00	17:00	18:00
  sorah		1:00:00	18:00	19:00
  Takayuki Tominaga	年忘れ	1:00:00	19:00	20:00
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
  'number' => NUMBER,
  'date' => DATE,
  'twipla_url' => TWIPLA_URL,
  'timetable' => timetable,
}

output_path = File.expand_path('../data/event.yml', __dir__)
File.write(output_path, YAML.dump(data))
