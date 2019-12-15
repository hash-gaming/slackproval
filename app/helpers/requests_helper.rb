module RequestsHelper
  def time_ago(timestamp)
    delta = Time.now.to_i - timestamp
    case delta
    when 0..30         then "just now"
    when 31..119       then "about a minute ago"
    when 120..3599     then "#{delta / 60} minutes ago"
    when 3600..86399   then "#{(delta / 3600).round} hours ago"
    when 86400..259199 then "#{(delta / 86400).round} days ago"
    else Time.at(timestamp).strftime('%d %b %Y %I:%M %p')
    end
end
end
