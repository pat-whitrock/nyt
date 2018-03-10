require 'net/http'

class NytStoryCollection
  CONTENT_URI = URI('http://np-ec2-nytimes-com.s3.amazonaws.com/dev/test/nyregion2.js').freeze

  def all
    @all ||= articles.map do |article|
      article.slice(:byline, :headline, :lastPublished, :summary, :url, :images)
    end
  end

  private

  def articles
    @articles ||= assets.select { |asset| asset[:type] == 'Article' }
  end

  def assets
    @assets ||= whitelisted_response[:content].flat_map do |section|
      section[:collections].flat_map do |collection|
        collection[:assets]
      end
    end
  end

  def response
    @response ||= JSON.parse(Net::HTTP.get(CONTENT_URI))
  end

  def whitelisted_response
    @whitelisted_response ||= ActionController::Parameters.new(response).require(:page).permit(
      content: [
        collections: [
          assets: [
            :byline,
            :headline,
            :lastPublished,
            :summary,
            :type,
            :url,
            images: [
              types: [
                :content,
                :type
              ]
            ]
          ]
        ]
      ]
    )
  end
end
