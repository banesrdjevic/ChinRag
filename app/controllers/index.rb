get '/' do
  erb :index
end

get '/links' do

  apple = all_logic(params)
  formatter(apple)

end
