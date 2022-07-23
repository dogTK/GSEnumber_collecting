# curl で　取得
require_relative "./curl_builder.rb"
require 'json'

c = CurlBuilder.new
c.exec(base_url: "http://aoe.dbcls.jp/api/search", method: "GET", params: {fulltext: ARGV[0], Technology: "sequencing", Organisms: ARGV[1], page: 1, size: 10000}, headers: {"X-Hoge": "myheader", "Content-Type": "application/json"}, body_filename: "body.json")

s=[]
File.open("response"){|f| s << f.read }
File.delete("response") if File.exist?("response")

parse_response=JSON.parse(s[0])
file1 = File.new('GSE.csv', 'w')
file1 << "GSEnumber" + ","
file1 << "Description" + "\n"

parse_response["data"].each do |data|
    file1 << data["GSE"] + ","
    file1 << '"'
    file1 << data["Description"]
    file1 << '"' + "\n"
    File.delete("response") if File.exist?("response")
end
