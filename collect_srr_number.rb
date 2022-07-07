# curl で　取得
require_relative "./curl_builder.rb"
require 'json'

c = CurlBuilder.new
c.exec(base_url: "http://aoe.dbcls.jp/api/search", method: "GET", params: {fulltext: ARGV[0], Technology: "sequencing", Organisms: "homo%20sapiens", page: 1, size: 10000}, headers: {"X-Hoge": "myheader", "Content-Type": "application/json"}, body_filename: "body.json")

s=[]
File.open("response"){|f| s << f.read }
parse_response=JSON.parse(s[0])

parse_response["data"].each do |data|
    p data["GSE"]
end

File.delete("response") if File.exist?("response")
