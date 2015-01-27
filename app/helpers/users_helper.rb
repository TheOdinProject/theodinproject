module UsersHelper
  def gravatar_url(user, size)
    gravatar_hash = Digest::MD5.hexdigest(user.email.strip.downcase)
    default_url = "http://www.gravatar.com/avatar/436053b3e050d4156773bc04cfb167fe?s=#{size}"
    # #{root_url}assets/odin_head_silhouette_2_pale.gif
    gravatar_url = "http://www.gravatar.com/avatar/#{gravatar_hash}?s=#{size}&d=#{default_url}"
  end

  def twitter_url(user)
    if user.twitter
      "http://www.twitter.com/#{user.twitter.sub('@', '')}"
    else
      ""
    end
  end 
end
