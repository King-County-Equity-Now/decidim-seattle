
FactoryBot.define do
  factory :equity_composite do
    gid { 1 }
    objectid { 1 }
    geoid10 { "53033005900" }
    name10 { "59" }
    namelsad10 { "Census Tract 59" }
    total_acres { 447.9 } 
    people_of_color_percent { 0.18 }
    people_of_color_percentile { 0.241e0 }
    english_less_than_very_well_percent { 0.013 }
    english_less_than_very_well_percentile { 0.098 }
    foreign_born_percent { 0.095 }
    foreign_born_percentile { 0.24 }
    income_below_200_percent_of_poverty_percent { 0.19 }
    income_below_200_percent_of_poverty_percentile { 0.48 }
    education_less_than_bachelors_percent { 0.21 }
    education_less_than_bachelors_percentile { 0.076 }
    adults_with_no_leisure_physical_activity_percent { 0.11 }
    adults_with_diabetes_percent { 0.04 }
    adults_that_are_obese_percent { 0.2 }
    adults_with_poor_mental_health_percent { 0.10 }
    adults_with_asthma_percent { 0.095 }
    adults_with_disability_percent { 0.053 }
    low_life_expectancy_at_birth_percent { 0.86 }
    adults_with_no_leisure_physical_activity_percentile { 0.18 }
    adults_with_diabetes_percentile { 0.14 }
    adults_that_are_obese_percentile { 0.082 }
    adults_with_poor_mental_health_percentile { 0.60 }
    adults_with_asthma_percentile { 0.81 }
    adults_with_disability_percentile { 0.07 }
    low_life_expectancy_at_birth_percentile { 0.12 }
    composite_index_percentage { 0.166 }
    composite_index_quintile { "Lowest" }
    race_english_languge_learners_index_percentage { 0.18 }
    race_english_languge_learners_index_quintile { "Lowest" }
    socioeconomic_index_percentage { 0.24 }
    socioeconomic_index_quintile { "Second lowest" }
    health_index_percentage { 0.26 }
    health_index_quintile { "Second lowest" }
    shape_area { 19511373.76 }
    shape_length { 24649.76 }
  end
end