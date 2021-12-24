require 'rails_helper'

RSpec.describe 'Astronaut Index' do
  it 'lists all astronauts and attributes' do
    neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "commander")
    buzz = Astronaut.create!(name: "Buzz Aldrin", age: 40, job: "engineer")
    sally = Astronaut.create!(name: "Sally Ride", age: 38, job: "chief officer")
    visit '/astronauts'

    expect(page).to have_content(neil.name)
    expect(page).to have_content(buzz.name)
    expect(page).to have_content(sally.name)

    expect(page).to have_content(sally.job)
    expect(page).to have_content(sally.age)
  end

  it 'shows average age of astronauts' do

    neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "commander")
    buzz = Astronaut.create!(name: "Buzz Aldrin", age: 40, job: "engineer")
    sally = Astronaut.create!(name: "Sally Ride", age: 38, job: "chief officer")
    visit '/astronauts'

    expect(page).to have_content("Average Age: 38.33")
  end

  it 'lists missions in alphabetical order' do
    neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "commander")
    buzz = Astronaut.create!(name: "Buzz Aldrin", age: 40, job: "engineer")
    sally = Astronaut.create!(name: "Sally Ride", age: 38, job: "chief officer")

    capricorn = Mission.create!(title: "Capricorn 4", time_in_space: 300)
    apollo = Mission.create!(title: "Apollo 13", time_in_space: 400)
    pisces = Mission.create!(title: "Pisces 12", time_in_space: 200)

    neil.missions << apollo
    buzz.missions << apollo
    neil.missions << capricorn
    sally.missions << capricorn
    sally.missions << pisces
    buzz.missions << pisces
    neil.missions << pisces

    visit '/astronauts'

    expect(page).to have_content(apollo.title)
    expect(page).to have_content(capricorn.title)
    expect(page).to have_content(pisces.title)
    expect(apollo.title).to appear_before(capricorn.title)
  end

  it 'shows total time_in_space for each astronaut' do
    neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "commander")
    buzz = Astronaut.create!(name: "Buzz Aldrin", age: 40, job: "engineer")
    sally = Astronaut.create!(name: "Sally Ride", age: 38, job: "chief officer")

    capricorn = Mission.create!(title: "Capricorn 4", time_in_space: 300)
    apollo = Mission.create!(title: "Apollo 13", time_in_space: 400)
    pisces = Mission.create!(title: "Pisces 12", time_in_space: 200)

    neil.missions << apollo
    buzz.missions << apollo
    neil.missions << capricorn
    sally.missions << capricorn
    sally.missions << pisces
    buzz.missions << pisces
    neil.missions << pisces

    visit '/astronauts'

      expect(page).to have_content('Time in space: 900 days')

      expect(page).to have_content('Time in space: 600 days')

      expect(page).to have_content('Time in space: 500 days')
  end
end
