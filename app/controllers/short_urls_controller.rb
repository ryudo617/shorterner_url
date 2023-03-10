class ShortUrlsController < ApplicationController

  def encode
    long_url = params_permit.dig(:long_url)

    # Generate a unique identifier for the URL
    code = SecureRandom.urlsafe_base64(6)

    # Create a new short URL record in the database
    short_url = ShortUrl.create!(long_url: long_url, code: code)

    # Return the short URL to the client
    redirect_to short_url && decodes_path || encodes_path 
  end

  def decode
    code = params_permit.dig(:long_url).split("/").last

    # Look up the short URL record in the database
    short_url = ShortUrl.find_by(code: code)

    unless short_url.present?
      # Return a 404 error if the short URL is not found
      render plain: "Not Found", status: 404
    end

    redirect_to decodes_path(short_url: short_url.long_url)
  end

  private

  def params_permit
    params.require(:short_url).permit(:long_url, :code)
  end

end
