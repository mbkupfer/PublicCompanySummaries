require "mechanize"

#business summary text = page.css('div#rightcol table#yfncsumtab p').text


=begin

1.take and input of company tickers
2.using a loop fetch the yahoo finance URI for each ticker
3.parse the result for business summary text and output to a file

Switch the URI after each loop iteration: 
  URL: http://finance.yahoo.com/q/pr?s=[ticker]
  page.uri.query = "s=[ticker]"
  page = agent.get(page.uri)

=end

tickers = ARGV
agent = Mechanize.new
fname = "./Output/summaries" + Time.now.to_s + ".txt"  
file = File.new(fname, 'w')

tickers.each do |ticker|
  url  = %(http://finance.yahoo.com/q/pr?s=) + "#{ticker}"
  page = agent.get(url)
  text = "#{ticker} \n\n" 
  text <<  page.css('div#rightcol table#yfncsumtab p').text + "\n\n"
  file.write(text)
end

file.close
