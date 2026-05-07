require 'yaml'
require 'erb'
require 'cgi'
require 'fileutils'

EVENT_NUMBER = 42
EVENT_TITLE = "第#{EVENT_NUMBER}回 高専DJ部"
VENUE = '茶箱 sabaco (西早稲田)'
VENUE_ADDRESS = '東京都新宿区西早稲田2-1-19 YKビル B1F'
FEE = '2000円（+1drink 700円）'
HASHTAG = '#kosendj'
TWITCH_URL = 'https://www.twitch.tv/sabaco_waseda'

DATA_PATH   = File.expand_path('../data/event.yml', __dir__)
OUTPUT_PATH = File.expand_path('../tmp/twipla.html', __dir__)

event = YAML.load_file(DATA_PATH)

def h(text)
  CGI.escapeHTML(text.to_s)
end

WRAP_STYLE = "font-family:'Hiragino Kaku Gothic ProN','Noto Sans JP',sans-serif;line-height:1.75;letter-spacing:.04em;color:#1a1a2e;"

H2_STYLE = 'font-size:1.05rem;font-weight:700;letter-spacing:.24em;color:#6f4bff;border-left:4px solid #6f4bff;padding:2px 0 2px 12px;margin:0 0 6px;text-transform:uppercase;'
H2_SUB_STYLE = 'font-size:.82rem;letter-spacing:.16em;color:#6b6e80;margin:0 0 14px;padding-left:16px;'

LABEL_STYLE = 'display:block;font-size:.7rem;letter-spacing:.22em;text-transform:uppercase;color:#6f4bff;margin-bottom:2px;'
VALUE_STYLE = 'display:block;font-size:1rem;color:#1a1a2e;'

LINK_STYLE = 'color:#6f4bff;border-bottom:1px solid rgba(111,75,255,.4);'

NOTICE_STYLE = 'background:#fff7e6;border:1px solid #ffd97a;border-radius:12px;padding:14px 18px;margin:12px 0 24px;color:#5a4500;'
NOTICE_TITLE_STYLE = 'font-weight:700;letter-spacing:.08em;color:#8a5a00;margin:0 0 6px;'

TABLE_STYLE = 'width:100%;border-collapse:collapse;margin:6px 0 18px;'
TR_STYLE = 'border-bottom:1px solid rgba(111,75,255,.15);'
TIME_TD_STYLE = 'padding:12px 16px 12px 8px;width:80px;color:#6f4bff;font-weight:700;letter-spacing:.08em;font-variant-numeric:tabular-nums;vertical-align:top;'
DJ_TD_STYLE = 'padding:12px 8px 12px 0;vertical-align:top;'
SCREEN_NAME_STYLE = 'display:block;font-weight:700;font-size:1rem;color:#1a1a2e;margin-bottom:2px;'
GENRE_STYLE = 'display:block;color:#5a5d70;font-size:.95rem;line-height:1.5;'

CARD_STYLE = 'background:#fafaff;border:1px solid rgba(111,75,255,.18);border-radius:14px;padding:18px 20px;margin:0 0 24px;'

INFO_GRID_STYLE = 'display:flex;flex-wrap:wrap;gap:18px 28px;margin:6px 0 0;'
INFO_ITEM_STYLE = 'min-width:160px;'

TITLE_STYLE = 'font-size:1.6rem;font-weight:700;letter-spacing:.12em;margin:0 0 14px;color:#1a1a2e;'

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
      <p style="margin:0 0 6px;font-weight:700;"><%= h(VENUE) %></p>
      <p style="margin:0 0 6px;color:#4a4d60;font-size:.95rem;"><%= h(VENUE_ADDRESS) %></p>
      <p style="margin:0;color:#4a4d60;font-size:.95rem;">東京メトロ東西線 早稲田駅 2,3b 出口より徒歩約5分</p>
    </div>

  </div>
ERB

html = template.result(binding)

FileUtils.mkdir_p(File.dirname(OUTPUT_PATH))
File.write(OUTPUT_PATH, html)

puts "Generated: #{OUTPUT_PATH}"
