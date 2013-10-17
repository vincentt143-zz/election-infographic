
Member.delete_all
file = File.open("db/federal_election_candidates.csv")

IO.foreach(file) do |line|
  data = line.split(",")
  break if data[1] == "\"S\""
  next if data[0] == "\"txn_nm\""
  next if data[8] != "\"Liberal\"" and data[8] != "\"Australian Labor Party\""
  electorate_name = data[4].gsub(/["]/, "")
  electorate = Electorate.find_by(:name => "#{electorate_name}")
  if data[8] == "\"Liberal\""
    party = Party.find_by(:name => "Liberal Party of Australia")
  else
    party = Party.find_by(:name => "Australian Labor Party (ALP)")
  end
  member = Member.new
  member.first_name = data[7].gsub(/["]/, "")
  member.last_name = data[6].gsub(/["]/, "").capitalize
  member.electorate = electorate
  member.party = party
  member.save
end