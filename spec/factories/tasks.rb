FactoryBot.define do
  factory :task do
    name { "建立项目模型(未完成)" }
    association :project

    trait :is_completed do
      name { "建立项目模型(已完成)" }
      completed_at { Time.now }
    end
  end
end
