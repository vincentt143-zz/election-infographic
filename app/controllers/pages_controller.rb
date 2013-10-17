class PagesController < ApplicationController
  def index
    render :pages => "index"
  end

  def fetch
    name = params[:electorate]
    electorate = Electorate.find_by_name name

    age = AgeStatistic.find_by(:electorate  => electorate)
    gender = GenderStatistic.find_by(:electorate  => electorate)
    religion = ReligionStatistic.find_by(:electorate  => electorate)
    response = {:name => electorate.name, :liberal_votes => electorate.liberal_votes, :liberal_percentage => electorate.liberal_percentage,
                :labor_votes => electorate.labor_votes, :labor_percentage => electorate.labor_percentage, :age => age, :gender => gender,
                :religion => religion}
    puts response
    render json: response
  end
end
