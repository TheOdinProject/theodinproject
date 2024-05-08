if Rails.env.development? || ENV['STAGING']
  names = %w[kevin rachel austin sully tatiana briggs leo grace asartea manon tester]

  names.each do |name|
    User.find_or_create_by!(email: "#{name}@odin.com") do |user|
      user.username = name
      user.password = 'password'
      user.admin = true
    end
  end

  AdminUser.find_or_create_by!(email: 'admin@odin.com') do |admin_user|
    admin_user.name = 'admin'
    admin_user.password = 'password123'
  end
end
