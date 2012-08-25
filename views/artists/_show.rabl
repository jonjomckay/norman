attributes :id, :name, :slug
node(:image, :if => lambda { |m| !m.images.empty? }) do |i|
    {
        :huge => {
             :width => i.images[0].image.width,
             :height => i.images[0].image.height,
             :url => i.images[0].image.url
         },
        :hd => {
            :width => 1920,
            :height => 1080,
            :url => i.images[0].image.thumb('1920x1080#n').url,
        },
        :large => {
            :width => 700,
            :height => 400,
            :url => i.images[0].image.thumb('700x400#n').url
        },
        :medium => {
            :width => 300,
            :height => 200,
            :url => i.images[0].image.thumb('300x200#n').url
        },
        :tiny => {
            :width => 75,
            :height => 75,
            :url => i.images[0].image.thumb('75x75#n').url
        }
    }
end