class Rack::Attack
  Rack::Attack.enabled = ENV['ENABLE_RACK_ATTACK'] || Rails.env.production?

  Rack::Attack.cache.store = Redis.new(url: ENV['REDIS_FOR_RACK_ATTACK_URL']) if ENV['REDIS_FOR_RACK_ATTACK_URL']

  ### Throttle Spammy Clients ###

  # If any single client IP is making tons of requests, then they're
  # probably malicious or a poorly-configured scraper. Either way, they
  # don't deserve to hog all of the app server's CPU. Cut them off!
  #
  # Note: If you're serving assets through rack, those requests may be
  # counted by rack-attack and this throttle may be activated too
  # quickly. If so, enable the condition to exclude them from tracking.

  # Throttle all requests by IP (60rpm)
  #
  # Key: "rack::attack:#{Time.now.to_i/:period}:req/ip:#{req.ip}"
  throttle('req/ip', limit: 300, period: 5.minutes, &:ip)

  ### Prevent Brute-Force Login Attacks ###

  # The most common brute-force login attack is a brute-force password
  # attack where an attacker simply tries a large number of emails and
  # passwords to see if any credentials match.
  #
  # Another common method of attack is to use a swarm of computers with
  # different IPs to try brute-forcing a password for a specific account.

  # Throttle POST requests to /users/sign_in by IP address
  #
  # Key: "rack::attack:#{Time.now.to_i/:period}:logins/ip:#{req.ip}"
  throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
    req.ip if req.path == '/users/sign_in' && req.post?
  end

  # Throttle POST requests to /login by email param
  #
  # Key: "rack::attack:#{Time.now.to_i/:period}:logins/email:#{normalized_email}"
  throttle('logins/email', limit: 5, period: 20.seconds) do |req|
    if req.path == '/users/sign_in' && req.post?
      # Normalize the email, using the same logic as your authentication process, to
      # protect against rate limit bypasses. Return the normalized email if present, nil otherwise.
      req.params['email'].to_s.downcase.gsub(/\s+/, '').presence
    end
  end

  # Throttle POST requests to /sign_up by IP address
  #
  # Key: "rack::attack:#{Time.now.to_i/:period}:sign_ups/ip:#{req.ip}"
  throttle('sign_ups/ip', limit: 5, period: 20.seconds) do |req|
    req.ip if req.path == '/users' && req.post?
  end

  # Throttle PATCH requests to /users/password_reset by IP address
  #
  # Key: "rack::attack:#{Time.now.to_i/:period}:password_resets/ip:#{req.ip}"
  throttle('password_resets/ip', limit: 5, period: 20.seconds) do |req|
    req.ip if req.path == '/users/password_reset' && req.post?
  end

  ### Custom Throttling

  throttle('admin/logins/ip', limit: 5, period: 20.seconds) do |req|
    req.ip if req.path == '/admin_v2/sign_in' && req.post?
  end

  Rack::Attack.throttle('report_ip', limit: 3, period: 60) do |request|
    request.ip if request.path.ends_with?('/flags') && request.post?
  end

  Rack::Attack.throttle('report_ip', limit: 5, period: 60) do |request|
    request.ip if request.path.ends_with?('/preview/share.turbo_stream') && request.post?
  end
end
