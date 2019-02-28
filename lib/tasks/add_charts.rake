namespace :add_charts do

  desc "TODO"
  task add_box_whisker_data: :environment do
		chapters = [1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 27]
		chapters.each do |ch|
			@common_sw = CommonWord.where("chapter_num = '#{ch.to_s}'").all.pluck(:verse_num_sw)
			@newHash = CommonWord.getCommonCount(@common_sw)
			@newHash = @newHash.sort_by { |key| key }.to_h
			@sorted = @newHash.sort_by { |key, value| value}
			len = @sorted.length


      if len%2 == 0 
        median = ((@sorted[(len/2)-1][1].to_f + @sorted[(len/2)][1].to_f)/2) 
        first_quartile = @sorted[((len/2)/2)][1].to_f 
        third_quartile = @sorted[((len/2)) + ((len/2)/2)][1].to_f 
      else 
        median = @sorted[(len/2)][1] 
        if (((len/2)/2)%2 == 0) 
          lowerI = ((len/2)-1) 
          higherI = ((len/2)+1) 
          lli = (lowerI/2) 
          lhi = ((lowerI/2)+1) 
          hli = ((higherI+len)/2) 
          hhi = (((higherI+len)/2)+1) 
          first_quartile = ((@sorted[lli][1].to_f + @sorted[lhi][1].to_f)/2.0) 
          third_quartile = ((@sorted[hli-1][1].to_f + @sorted[hhi-1][1].to_f)/2.0) 
        else 
          first_quartile = @sorted[((len/2)/2)][1].to_f
          third_quartile = @sorted[((len/2)/2) + (len/2) + 1][1].to_f
        end 
      end 


			least = @sorted[0][1].to_f
			greatest = @sorted[len-1][1].to_f
			@chart = Chart.new
			@chart.chart_type = 'box_whisker_plot'
			@chart.chapter = ch
			@chart.save
			@bwp = @chart.box_whisker_plots.create(:median => median, :first_quartile => first_quartile, :third_quartile => third_quartile, :least => least, :greatest => greatest)
			@bwp.median = median
			@bwp.least = least
			@bwp.greatest = greatest
			@bwp.first_quartile = first_quartile
			@bwp.third_quartile = third_quartile
			@bwp.chart_id = @chart.id
			@bwp.save
			@chart.save
		end
  end

end
