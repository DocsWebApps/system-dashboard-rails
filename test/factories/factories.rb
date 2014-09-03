FactoryGirl.define do
  
  factory :company do
    name 'MyBusiness'
  end
  
  factory :contact do
    contact 'admin@admin.com'
    message 'For site problems please contact:'
  end
  
  factory :comment do
    comment 'Test comment'
  end
  
  factory :system do
    name 'kirk'
    row_id 1
    status 'green'
    
    factory :system_with_incidents do
      ignore do
        incident_count 1
      end
      
      after(:create) do |system, evaluator|
        FactoryGirl.create_list(:incident, evaluator.incident_count, system: system)
        FactoryGirl.create_list(:incident_history, evaluator.incident_count, system: system)
      end
   end
  end
  
  factory :incident do
    severity 'P2'
    status 'Open'
    date Date.today
    time Time.now
    hp_ref 'HP12345678'
    description 'Test description'
  end
  
  factory :incident_history do
    severity 'P2'
    status 'Open'
    date Date.today - 10
    time '12:00'
    hp_ref 'HP98765432'
    description 'Test description'
    closed_at (Time.now - 76.hours)
  end

  factory :user do
    name 'AdminUser'
    email 'admin@admin.com'
    password 'abc12345'
    password_confirmation 'abc12345'  
  end
  
  factory :role do
    name 'admin'
    description 'Admin Role'
    
    factory :role_with_users do
      ignore do
        user_count 1
      end
    
      after(:create) do |role, evaluator|
        FactoryGirl.create_list(:user, evaluator.user_count, role: role)
      end
    end
  end
  
end