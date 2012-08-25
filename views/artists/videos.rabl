object false
node :videos do
    @videos.map do |v|
        {
            :id => v.unique_id,
            :title => v.title,
            :url => v.player_url,
            :images =>
                {
                    :large => {
                        :width => v.thumbnails[2].width,
                        :height => v.thumbnails[2].height,
                        :url => v.thumbnails[2].url,
                    },
                    :medium => {
                        :width => v.thumbnails[1].width,
                        :height => v.thumbnails[1].height,
                        :url => v.thumbnails[1].url,
                    },
                    :small => {
                        :width => v.thumbnails[0].width,
                        :height => v.thumbnails[0].height,
                        :url => v.thumbnails[0].url,
                    }
                },
            :uploaded => v.uploaded_at
        }
    end
end