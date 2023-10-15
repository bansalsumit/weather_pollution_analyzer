module DateHelper
  def convert_unix_timestamp_to_date_time(seconds)
    Time.at(seconds).to_datetime
  end
end
