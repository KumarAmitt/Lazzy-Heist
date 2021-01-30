def generate_csv(option, dataset)
  filename = case option
             when '11' then 'top_rated_movies'
             when '12' then 'popular_movies'
             when '21' then 'top_rated_TV_Shows'
             else 'popular_TV_Shows'
             end

  CSV.open("../csv/#{filename}.csv", 'w') do |csv|
    csv << %w[Sl.No. Name Year Rating Reviews Watch_Trailer]
    dataset.each_with_index do |e, i|
      csv << [i + 1, e.name, e.year, e.rating, e.reviews, e.trailer_link]
    end
  end
end
