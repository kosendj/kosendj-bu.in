require 'yaml'

DATE = '2026.06.13 (Sat.) 14:00-20:00'
TWIPLA_URL = 'https://twipla.jp/events/727590'

INPUT = <<~TEXT
  名前	ジャンル	所要時間	開始時間	終了時刻
  あそなす	CDJはやり方忘れてしまったので楽器でいい感じに...	0:45:00	14:00	14:45
  うなすけ	Progressive House軸	0:45:00	14:45	15:30
  Takayuki Tominaga	たのしい	0:45:00	15:30	16:15
  Rooq	速いハウス	0:45:00	16:15	17:00
  furaji	5月で現在の会社が無くなりまstep	0:45:00	17:00	17:45
  ちゃんにく	グルミク収録曲	0:45:00	17:45	18:30
  sylph01/G4きゅーぶ	RubyIlluminationsの残り物(170+)	0:45:00	18:30	19:15
  HolyGrail	RubyIlluminations 後夜祭	0:45:00	19:15	20:00
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
