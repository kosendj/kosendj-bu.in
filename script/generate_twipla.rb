require 'yaml'
require 'erb'
require 'cgi'
require 'fileutils'

VENUE = '茶箱 sabaco (西早稲田)'
VENUE_ADDRESS = '東京都新宿区西早稲田2-1-19 YKビル B1F'
FEE = '2300円（+1drink 700円）'
HASHTAG = '#kosendj'
TWITCH_URL = 'https://www.twitch.tv/sabaco_waseda'

DATA_PATH   = File.expand_path('../data/event.yml', __dir__)
OUTPUT_PATH = File.expand_path('../tmp/twipla.html', __dir__)

event = YAML.load_file(DATA_PATH)
EVENT_TITLE = "第#{event['number']}回 高専DJ部"

def h(text)
  CGI.escapeHTML(text.to_s)
end

FONT_JP    = "'Hiragino Kaku Gothic ProN','Noto Sans JP','Yu Gothic',sans-serif"
FONT_JP_MI = "'Hiragino Mincho ProN','Yu Mincho','Zen Old Mincho',serif"
FONT_MONO  = "'SFMono-Regular','Menlo','Consolas','Liberation Mono',monospace"

WRAP_STYLE = "font-family:#{FONT_JP};line-height:1.85;letter-spacing:.04em;color:#0a0a0a;"

H2_STYLE = "font-family:#{FONT_MONO};font-size:.82rem;font-weight:700;letter-spacing:.32em;color:#0a0a0a;border-left:3px solid #00e0bf;padding:2px 0 2px 14px;margin:0 0 6px;text-transform:uppercase;"
H2_SUB_STYLE = "font-family:#{FONT_JP_MI};font-size:.95rem;letter-spacing:.2em;color:#6c685e;margin:0 0 18px;padding-left:17px;"

LABEL_STYLE = "display:block;font-family:#{FONT_MONO};font-size:.7rem;letter-spacing:.24em;text-transform:uppercase;color:#6c685e;margin-bottom:4px;"
VALUE_STYLE = "display:block;font-family:#{FONT_JP_MI};font-weight:700;font-size:1.1rem;color:#0a0a0a;letter-spacing:.02em;"

LINK_STYLE = 'color:#00e0bf;border-bottom:1px solid rgba(0,224,191,.4);'

NOTICE_STYLE = "background:#0a0a0a;border:1px solid rgba(243,239,228,.28);border-left:3px solid #00e0bf;border-radius:0;padding:20px 22px;margin:12px 0 28px;color:#f3efe4;"
NOTICE_TITLE_STYLE = "font-family:#{FONT_MONO};font-size:.78rem;font-weight:700;letter-spacing:.24em;text-transform:uppercase;color:#00e0bf;margin:0 0 8px;"

TABLE_STYLE = 'width:100%;border-collapse:collapse;margin:6px 0 24px;'
TR_STYLE = 'border-bottom:1px solid rgba(10,10,10,.18);'
TIME_TD_STYLE = "padding:14px 18px 14px 8px;width:90px;font-family:#{FONT_MONO};color:#0a0a0a;font-weight:700;font-size:1.05rem;letter-spacing:.06em;font-variant-numeric:tabular-nums;vertical-align:top;"
DJ_TD_STYLE = 'padding:14px 8px 14px 0;vertical-align:top;'
SCREEN_NAME_STYLE = "display:block;font-family:#{FONT_JP_MI};font-weight:700;font-size:1.05rem;color:#0a0a0a;margin-bottom:4px;letter-spacing:.02em;"
GENRE_STYLE = 'display:block;color:#6c685e;font-size:.9rem;line-height:1.6;'

CARD_STYLE = 'background:#efe9d9;border:1px solid #c8c0a4;border-radius:0;padding:22px 24px;margin:0 0 28px;'

INFO_GRID_STYLE = 'display:flex;flex-wrap:wrap;gap:20px 32px;margin:8px 0 0;'
INFO_ITEM_STYLE = 'min-width:160px;'

TITLE_STYLE = "font-family:#{FONT_JP_MI};font-size:1.7rem;font-weight:700;letter-spacing:.04em;margin:0 0 16px;color:#0a0a0a;"

template = ERB.new(<<~ERB, trim_mode: '-')
  <div style="<%= WRAP_STYLE %>">

    <h2 style="<%= H2_STYLE %>">ABOUT</h2>
    <p style="<%= H2_SUB_STYLE %>">高専DJ部 って？</p>
    <p style="margin:0 0 12px;">「高専DJ部」は高専生やそのOB/OGが集まってDJをやる部活動です。オールジャンル、その時々でDJがかけたい曲を流すタイプのクラブイベントです。</p>
    <p style="margin:0 0 24px;">「高専」の名を冠していますが、どなたでも参加していただけます。クラブは初めてという方でも、是非お気軽にお越しください！</p>

    <div style="<%= NOTICE_STYLE %>">
      <p style="<%= NOTICE_TITLE_STYLE %>">TwiPla での参加登録について</p>
      <p style="margin:0;">このTwiPlaは参加人数の把握のために使用しています。当日、会場に着いてからの参加登録でも問題ありません。</p>
    </div>

    <h2 style="<%= H2_STYLE %>">EVENT</h2>
    <p style="<%= H2_SUB_STYLE %>">イベント概要</p>
    <div style="<%= CARD_STYLE %>">
      <p style="<%= TITLE_STYLE %>"><%= h(EVENT_TITLE) %></p>
      <div style="<%= INFO_GRID_STYLE %>">
        <div style="<%= INFO_ITEM_STYLE %>">
          <span style="<%= LABEL_STYLE %>">Date</span>
          <span style="<%= VALUE_STYLE %>"><%= h(event['date']) %></span>
        </div>
        <div style="<%= INFO_ITEM_STYLE %>">
          <span style="<%= LABEL_STYLE %>">Venue</span>
          <span style="<%= VALUE_STYLE %>"><%= h(VENUE) %></span>
        </div>
        <div style="<%= INFO_ITEM_STYLE %>">
          <span style="<%= LABEL_STYLE %>">Fee</span>
          <span style="<%= VALUE_STYLE %>"><%= h(FEE) %></span>
        </div>
        <div style="<%= INFO_ITEM_STYLE %>">
          <span style="<%= LABEL_STYLE %>">Hashtag</span>
          <span style="<%= VALUE_STYLE %>"><a href="https://x.com/search?q=%23kosendj&amp;src=typed_query&amp;f=live" style="<%= LINK_STYLE %>" target="_blank" rel="noopener"><%= h(HASHTAG) %></a></span>
        </div>
        <div style="<%= INFO_ITEM_STYLE %>">
          <span style="<%= LABEL_STYLE %>">Twitch</span>
          <span style="<%= VALUE_STYLE %>"><a href="<%= h(TWITCH_URL) %>" style="<%= LINK_STYLE %>" target="_blank" rel="noopener"><%= h(TWITCH_URL) %></a></span>
        </div>
      </div>
    </div>

    <h2 style="<%= H2_STYLE %>">TIMETABLE</h2>
    <p style="<%= H2_SUB_STYLE %>">タイムテーブル</p>
    <table style="<%= TABLE_STYLE %>"><tbody>
      <%- event['timetable'].each do |tt| -%>
      <tr style="<%= TR_STYLE %>">
        <td style="<%= TIME_TD_STYLE %>"><%= h(tt['time']) %></td>
        <td style="<%= DJ_TD_STYLE %>">
          <span style="<%= SCREEN_NAME_STYLE %>"><%= h(tt['screen_name']) %></span>
          <span style="<%= GENRE_STYLE %>"><%= h(tt['genre']) %></span>
        </td>
      </tr>
      <%- end -%>
    </tbody></table>

    <h2 style="<%= H2_STYLE %>">FEE</h2>
    <p style="<%= H2_SUB_STYLE %>">料金</p>
    <p style="margin:0 0 24px;font-size:1.05rem;"><%= h(FEE) %></p>

    <h2 style="<%= H2_STYLE %>">VENUE</h2>
    <p style="<%= H2_SUB_STYLE %>">会場</p>
    <div style="<%= CARD_STYLE %>">
      <p style="margin:0 0 8px;font-family:<%= FONT_JP_MI %>;font-weight:700;font-size:1.15rem;letter-spacing:.04em;color:#0a0a0a;"><%= h(VENUE) %></p>
      <p style="margin:0 0 6px;color:#6c685e;font-size:.9rem;"><%= h(VENUE_ADDRESS) %></p>
      <p style="margin:0;color:#6c685e;font-size:.9rem;">東京メトロ東西線 早稲田駅 2,3b 出口より徒歩約5分</p>
    </div>

  </div>
ERB

html = template.result(binding)

FileUtils.mkdir_p(File.dirname(OUTPUT_PATH))
File.write(OUTPUT_PATH, html)

puts "Generated: #{OUTPUT_PATH}"
