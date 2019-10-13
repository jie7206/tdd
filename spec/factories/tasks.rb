FactoryBot.define do

  factory :task do

    name { "建立项目模型(未完成)" }
    tdd_step { 0 }
    is_top { false }
    association :project

    trait :is_top do
      is_top { true }
    end

    trait :is_completed do
      name { "建立项目模型(已完成)" }
      tdd_step { $tdd_steps_array.size }
    end

    trait :tdd_step_eq_1 do
      tdd_step { 1 }
    end

    trait :tdd_step_eq_2 do
      tdd_step { 2 }
    end

  end

end
