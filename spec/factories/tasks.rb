FactoryBot.define do

  factory :task do

    name { "BuildProjectModel_uncomplete" }
    tdd_step { 0 }
    is_top { false }
    association :project

    trait :is_top do
      is_top { true }
    end

    trait :is_completed do
      name { "BuildProjectModel_completed" }
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
