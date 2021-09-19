if Rails.env == "production"
  Rails.application.config.session_store :cookie_store, key: "_hekani_social_media", domain: "hekani-social-media.herokuapp.com"
else
  Rails.application.config.session_store :cookie_store, key: "_hekani_social_media"
end
