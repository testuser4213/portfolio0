module AnswersHelper
  def format_timestamp(timestamp)
    l(timestamp, format: '%B %-d, %Y %H:%M:%S')
  end
end
