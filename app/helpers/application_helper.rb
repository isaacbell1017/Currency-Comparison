module ApplicationHelper
  def bitcoin_data_by_date(data)
    fields = []
    data.each do |datum|
      date = datum[0].split('-').join(', ')
      fields += ["Date.UTC(#{date}), #{datum[1].to_s}"]
    end
    
    html = '[[' + raw(fields.join('], [')) + ']]'
    return html
  end
end
